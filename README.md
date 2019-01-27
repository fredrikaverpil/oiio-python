# oiio-python

| Build pipeline | Status |
| ------------- | ------------- |
| win2016 | [![Build Status](https://fredrikaverpil.visualstudio.com/oiio-python/_apis/build/status/oiio-python-win2016?branchName=master)](https://fredrikaverpil.visualstudio.com/oiio-python/_build/latest?definitionId=5?branchName=master) |
| ubuntu 16.04 | [![Build Status](https://fredrikaverpil.visualstudio.com/oiio-python/_apis/build/status/oiio-python-ubuntu16.04?branchName=master)](https://fredrikaverpil.visualstudio.com/oiio-python/_build/latest?definitionId=6?branchName=master) |

## Download build artifacts

Check the build log and access:

    https://dev.azure.com/fredrikaverpil/oiio-python/_apis/build/builds/{build_id}/artifacts?artifactName={artifact_name}&api-version=5.0-preview.5

You get the build id from the "PublishBuildArtifact" CI task.

From the response, copy-paste the downloadUrl into your browser to download. For more info, read [here](https://docs.microsoft.com/sv-se/rest/api/azure/devops/build/artifacts/get%20artifact?view=azure-devops-rest-5.0).

## Notes

- [vcpkg/ports/openimageio](https://github.com/Microsoft/vcpkg/tree/master/ports/openimageio)
