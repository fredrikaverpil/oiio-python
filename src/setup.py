"""A setuptools based setup module.
See:
https://packaging.python.org/en/latest/distributing.html
https://github.com/pypa/sampleproject
"""

# Prefer setuptools over distutils
from setuptools import setup
from setuptools import find_packages

setup(
    name="[PACKAGE_NAME]",
    version="[VERSION]",
    description="[DESCRIPTION]",
    url="https://github.com/fredrikaverpil/oiio-python",
    packages=find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS dependent",
    ],
)
