# oiio-python

OpenImageIO Python 3.x package.

| Build pipeline | CI Status |
| ------------- | ------------- |
| Windows Server 2016 | [![Build Status](https://fredrikaverpil.visualstudio.com/oiio-python/_apis/build/status/oiio-python-win2016?branchName=master)](https://fredrikaverpil.visualstudio.com/oiio-python/_build/latest?definitionId=5?branchName=master) |
| Ubuntu 16.04<sup>1</sup> | [![Build Status](https://fredrikaverpil.visualstudio.com/oiio-python/_apis/build/status/oiio-python-ubuntu16.04?branchName=master)](https://fredrikaverpil.visualstudio.com/oiio-python/_build/latest?definitionId=6?branchName=master) |
| macOS 10.13 | [![Build Status](https://fredrikaverpil.visualstudio.com/oiio-python/_apis/build/status/oiio-python-macOS-10.13?branchName=master)](https://fredrikaverpil.visualstudio.com/oiio-python/_build/latest?definitionId=7&branchName=master) |

<sup>1</sup> Should also work on CentOS 7 for example.

## About the project

OpenImageIO is built using [vcpkg](https://github.com/Microsoft/vcpkg) and packaged into Python wheels on Windows, Linux and macOS platforms (thanks to [Azure Pipelines](https://azure.microsoft.com/en-us/services/devops/pipelines/)).

To make this work, some customization of the vcpkg port files were necessary and thus these modifications are stored in this repository.

## Download wheels

Download the wheels under "Releases". CI jobs produce wheels and they can be downloaded from the respective CI job.

## Usage

- Install the wheel: `pip install ...`
- From within Python, import OpenImageIO: `from oiio import OpenImageIO as oiio`

See the `tests` folder for code examples used to test the built wheels' functionality.

## Notes

- Official OpenImageIO repository at [OpenImageIO/oiio](https://github.com/OpenImageIO/oiio), note the `.travis.yml` and `appveyor.yml`
- The python3 files for oiio at [vcpkg/ports/python3](https://github.com/Microsoft/vcpkg/tree/master/ports/python3)
- The vcpkg files for oiio at [vcpkg/ports/openimageio](https://github.com/Microsoft/vcpkg/tree/master/ports/openimageio)
- Get SHA512 of file:
  - macOS: `openssl dgst -sha512 [FILE]`
- A new release is automatically performed when a commit is performed on the `master` branch.
- Updating to a newer OpenImageIO version:
  1. Update the `oiio.version` variable in the .yml files
  2. Update the version and SHA512 in the OpenImageIO port files.