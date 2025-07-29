import argparse
import sys

from Cocoa import (
    NSApplication,
    NSMenu,
    NSMenuItem,
    NSStatusBar,
    NSVariableStatusItemLength,
)
from PyObjCTools import AppHelper


class MenuBarIcon:
    def __init__(self, char, add_quit):
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

    app = NSApplication.sharedApplication()
    icons = []
    for i, char in enumerate(reversed_text):
        add_quit = i == 0 or i == len(reversed_text) - 1
        icons.append(MenuBarIcon(char, add_quit))

    print(
        "To quit go to the far right letter and left click, a dropdown menu will appear, with one of the options being quit."
    )
    AppHelper.runEventLoop()


if __name__ == "__main__":
    main()
