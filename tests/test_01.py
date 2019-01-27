import os

import OpenImageIO as oiio

img_src = oiio.ImageBuf(str(os.path.normpath('PATH_TO_FILE')))
rgb_img_src = oiio.ImageBuf()
oiio.ImageBufAlgo.channels(rgb_img_src, img_src, (0, 1, 2))

img_width = rgb_img_src.spec().full_width
img_height = rgb_img_src.spec().full_height

print(img_width, img_height)