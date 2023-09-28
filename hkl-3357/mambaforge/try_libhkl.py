"""Try to use the libhkl pre-built support."""
# gobject-introspection, to access libhkl
import gi
gi.require_version("Hkl", "5.0")

from gi.repository import Hkl as libhkl

# access some content
diffractometer_types = libhkl.factories()
assert isinstance(diffractometer_types, dict)
assert 5 < len(diffractometer_types) < 20
for i, dt in enumerate(sorted(diffractometer_types), start=1):
    print(f"{i} {dt}  {diffractometer_types[dt]}")

UserUnits = libhkl.UnitEnum.USER
assert UserUnits is not None

DefaultUnits = libhkl.UnitEnum.DEFAULT
assert DefaultUnits is not None

if "VERSION" in dir(libhkl):
    print(f"libhkl.VERSION={libhkl.VERSION}")
print(f"gi.__version__={gi.__version__}")
