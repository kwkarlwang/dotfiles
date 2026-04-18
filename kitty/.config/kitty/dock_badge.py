"""Custom kitten to set/clear the macOS dock badge on Kitty's icon."""
import ctypes
import ctypes.util


def main(args: list[str]) -> str:
    # no_ui=True skips main(), but it must exist
    pass


def _set_dock_badge(label: str) -> None:
    """Use ctypes to call NSApp.dockTile.setBadgeLabel_(label)."""
    objc = ctypes.cdll.LoadLibrary(ctypes.util.find_library("objc"))

    objc.objc_msgSend.restype = ctypes.c_void_p
    objc.objc_msgSend.argtypes = [ctypes.c_void_p, ctypes.c_void_p]
    objc.objc_getClass.restype = ctypes.c_void_p
    objc.sel_registerName.restype = ctypes.c_void_p

    def msg(obj, sel_name):
        sel = objc.sel_registerName(sel_name.encode())
        return objc.objc_msgSend(obj, sel)

    # NSApp = [NSApplication sharedApplication]
    ns_app_cls = objc.objc_getClass(b"NSApplication")
    app = msg(ns_app_cls, "sharedApplication")
    dock_tile = msg(app, "dockTile")

    if label:
        # Create NSString from label
        ns_string_cls = objc.objc_getClass(b"NSString")
        ns_alloc = msg(ns_string_cls, "alloc")
        sel_init = objc.sel_registerName(b"initWithUTF8String:")
        objc.objc_msgSend.argtypes = [
            ctypes.c_void_p,
            ctypes.c_void_p,
            ctypes.c_char_p,
        ]
        ns_label = objc.objc_msgSend(ns_alloc, sel_init, label.encode("utf-8"))
    else:
        ns_label = None

    # [dockTile setBadgeLabel:ns_label]
    sel_set = objc.sel_registerName(b"setBadgeLabel:")
    objc.objc_msgSend.argtypes = [
        ctypes.c_void_p,
        ctypes.c_void_p,
        ctypes.c_void_p,
    ]
    objc.objc_msgSend(dock_tile, sel_set, ns_label or 0)

    # [dockTile display]
    objc.objc_msgSend.argtypes = [ctypes.c_void_p, ctypes.c_void_p]
    msg(dock_tile, "display")


from kittens.tui.handler import result_handler  # noqa: E402


@result_handler(no_ui=True)
def handle_result(args: list[str], answer: str, target_window_id: int, boss) -> None:
    # Usage: kitty +kitten dock_badge.py <label>
    # Pass empty string or "0" to clear
    label = args[1] if len(args) > 1 else ""
    if label == "0":
        label = ""
    _set_dock_badge(label)
