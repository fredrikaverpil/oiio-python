"""Get width and height of EXR image."""

import os

from oiio import OpenImageIO as oiio


def image_dimensions(image_filepath):
    """Get image dimensions.

    params:
        image_filepath: str

    returns
        int, int: width, height

    """
    img_src = oiio.ImageBuf(image_filepath)
    rgb_img_src = oiio.ImageBuf()
    oiio.ImageBufAlgo.channels(rgb_img_src, img_src, (0, 1, 2))

    img_width = rgb_img_src.spec().full_width
    img_height = rgb_img_src.spec().full_height

    return img_width, img_height


def test_answer():
    """Verify image dimensions."""
    image_filepath = os.path.join(
        os.path.dirname(__file__), "img", "test_image_01.exr"
    )
    img_width, img_height = image_dimensions(image_filepath)
    assert img_width == 1024
    assert img_height == 1024
