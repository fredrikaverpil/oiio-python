"""Get width and height of EXR image."""

import os

from oiio import OpenImageIO as oiio

img_path = os.path.join(os.path.dirname(__file__), 'img', 'test_image_01.exr')
img_src = oiio.ImageBuf(img_path)
rgb_img_src = oiio.ImageBuf()
oiio.ImageBufAlgo.channels(rgb_img_src, img_src, (0, 1, 2))

img_width = rgb_img_src.spec().full_width
img_height = rgb_img_src.spec().full_height

print('Width: %s, height: %s' % (img_width, img_height))
