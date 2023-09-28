"""Try to use the libhkl pre-built support."""
# gobject-introspection, to access libhkl
import gi
import hkl
from hkl.user import *
from hkl.util import libhkl

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

sim4c = hkl.SimulatedE4CV("", name="sim4c")
sim4c.pa()

select_diffractometer(sim4c)
pa()
print(f"{cahkl(1, 1, 1)=}")
sim4c.move(1, 1, 1)
wh()

if "VERSION" in dir(libhkl):
    print(f"{libhkl.VERSION=}")
print(f"{gi.__version__=}")
