import argparse
import platform
import sys

IS_MAC = platform.system() == "Darwin"
IS_LINUX = platform.system() == "Linux"

if IS_MAC:
    from Cocoa import (
        NSApplication,
        NSMenu,
        NSMenuItem,
        NSStatusBar,
        NSVariableStatusItemLength,
    )
    from PyObjCTools import AppHelper
elif IS_LINUX:
    import signal

    import gi

    gi.require_version("Gtk", "3.0")
    gi.require_version("AppIndicator3", "0.1")
    from gi.repository import AppIndicator3, Gtk


class MenuBarIcon:
    def __init__(self, char, add_quit, quit_callback=None):
        if IS_MAC:
            self.status_item = NSStatusBar.systemStatusBar().statusItemWithLength_(
                NSVariableStatusItemLength
            )
            display_char = "\u00a0" if char == " " else char
            self.status_item.setTitle_(display_char)
            self.menu = NSMenu.alloc().init()
            self.menu.addItem_(
                NSMenuItem.alloc().initWithTitle_action_keyEquivalent_(
                    f"You clicked '{char}'", None, ""
                )
            )
            if add_quit:
                self.menu.addItem_(NSMenuItem.separatorItem())
                self.menu.addItem_(
                    NSMenuItem.alloc().initWithTitle_action_keyEquivalent_(
                        "Quit", "terminate:", ""
                    )
                )
            self.status_item.setMenu_(self.menu)
        elif IS_LINUX:
            # Use AppIndicator for tray icon
            self.indicator = AppIndicator3.Indicator.new(
                f"menuicon-{char}-{id(self)}",
                "",
                AppIndicator3.IndicatorCategory.APPLICATION_STATUS,
            )
            # Use the char as the label (AppIndicator doesn't support icon text, so use label)
            self.indicator.set_status(AppIndicator3.IndicatorStatus.ACTIVE)
            self.indicator.set_label(char, char)
            # Build menu
            self.menu = Gtk.Menu()
            item = Gtk.MenuItem(label=f"You clicked '{char}'")
            item.set_sensitive(False)
            self.menu.append(item)
            if add_quit:
                self.menu.append(Gtk.SeparatorMenuItem())
                quit_item = Gtk.MenuItem(label="Quit")
                quit_item.connect(
                    "activate",
                    lambda w: quit_callback() if quit_callback else Gtk.main_quit(),
                )
                self.menu.append(quit_item)
            self.menu.show_all()
            self.indicator.set_menu(self.menu)


def main():
    parser = argparse.ArgumentParser(
        description="Display reversed string as menu bar icons."
    )
    parser.add_argument(
        "text",
        type=str,
        default="HELLOW WORLD",
        help="Text to display in reverse, one character per icon, supports (all?) characters",
    )
    parser.add_argument(
        "repeat",
        type=int,
        nargs="?",
        default=1,
        help="Optional number of times to repeat the text",
    )
    parser.add_argument(
        "-s",
        "--separator",
        type=str,
        default="•",
        help="String to insert between repeated text",
    )
    parser.add_argument(
        "-b",
        "--begin",
        type=str,
        default="\u00a0",
        help="String to insert at the start of the string (before reversing) default is a space",
    )

    args = parser.parse_args()

    # Build the full string with repetitions and custom start
    parts = [args.text] * args.repeat
    full_text = args.separator.join(parts)
    reversed_text = (args.begin + full_text)[::-1]

    icons = []
    if IS_MAC:
        app = NSApplication.sharedApplication()
        for i, char in enumerate(reversed_text):
            add_quit = i == 0 or i == len(reversed_text) - 1
            icons.append(MenuBarIcon(char, add_quit))
        AppHelper.runEventLoop()
    elif IS_LINUX:
        # On Linux, quit all icons when any quit is pressed
        def quit_all(*a):
            Gtk.main_quit()

        for i, char in enumerate(reversed_text):
            add_quit = i == 0 or i == len(reversed_text) - 1
            icons.append(MenuBarIcon(char, add_quit, quit_callback=quit_all))
        # Handle Ctrl+C
        signal.signal(signal.SIGINT, lambda sig, frame: Gtk.main_quit())
        Gtk.main()
    else:
        print("This script only supports macOS and Linux.")
        sys.exit(1)


if __name__ == "__main__":
    main()
