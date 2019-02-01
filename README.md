# oiio-python

OpenImageIO Python 3.x package.

| Build pipeline | R&D Status | CI Status |
| ------------- | ------------- | ------------- |
| Windows Server 2016 | Wheels are building | [![Build Status](https://fredrikaverpil.visualstudio.com/oiio-python/_apis/build/status/oiio-python-win2016?branchName=master)](https://fredrikaverpil.visualstudio.com/oiio-python/_build/latest?definitionId=5?branchName=master) |
| Ubuntu 16.04 | Wheels are building | [![Build Status](https://fredrikaverpil.visualstudio.com/oiio-python/_apis/build/status/oiio-python-ubuntu16.04?branchName=master)](https://fredrikaverpil.visualstudio.com/oiio-python/_build/latest?definitionId=6?branchName=master) |
| macOS 10.13 | Wheels are building | [![Build Status](https://fredrikaverpil.visualstudio.com/oiio-python/_apis/build/status/oiio-python-macOS-10.13?branchName=master)](https://fredrikaverpil.visualstudio.com/oiio-python/_build/latest?definitionId=7&branchName=master) |

## About the project

OpenImageIO is built using [vcpkg](https://github.com/Microsoft/vcpkg) and packaged into Python wheels on Windows, Linux and macOS platforms (provided by [Azure Pipelines](https://azure.microsoft.com/en-us/services/devops/pipelines/)).

To make this work, some customization of the vcpkg port files were necessary and thus these modifications are stored in this repository.

## Download wheels

Since the project is still in a research phase, no releases have been made just yet. Instead, look at the Azure Pipeline CI builds corresponding to your platform and Python version, where wheels are stored as build artifacts.

When browsing an Azure Pipelines build, click the "Summary" link, and you will see the build artifacts (zipped Python wheels).

## Usage

- Install the wheel: `pip install ...`
- From within Python, import OpenImageIO: `from oiio import OpenImageIO as oiio`

## Notes

- Official OpenImageIO repository at [OpenImageIO/oiio](https://github.com/OpenImageIO/oiio), note the `.travis.yml` and `appveyor.yml`
- The python3 files for oiio at [vcpkg/ports/python3](https://github.com/Microsoft/vcpkg/tree/master/ports/python3)
- The vcpkg files for oiio at [vcpkg/ports/openimageio](https://github.com/Microsoft/vcpkg/tree/master/ports/openimageio)
- Get SHA512 of file:
  - macOS: `openssl dgst -sha512 [FILE]`