"""
HolaTimer icon generator — Heart Hourglass
Outputs: icon.png (1024x1024) and icon_foreground.png (1024x1024, transparent bg)
Run: python gen_icon.py
"""
from PIL import Image, ImageDraw
import os

SIZE = 1024
DIR  = os.path.dirname(os.path.abspath(__file__))

# ── Palette ─────────────────────────────────────────────────────────────────
BG_TOP  = (240, 98,  146)   # #F06292  light pink
BG_BOT  = (173, 24,  87)    # #AD1457  deep rose
DARK    = (61,  11,  46)    # #3D0B26  dark outline (like the bee)
WHITE   = (255, 255, 255)
PINK    = (233, 30,  140)   # #E91E8C  app main
SAND    = (248, 187, 217)   # #F8BBD9  light pink (hourglass fill)

# ── Heart geometry ───────────────────────────────────────────────────────────
# Two circles for top lobes + rectangle bridge + triangle for bottom tip
LX, LY, LR = 400, 378, 155   # left lobe center + radius
RX, RY, RR = 624, 378, 155   # right lobe center + radius
BRIM_Y = 452                  # where circles hand off to the triangle
TIP_Y  = 756                  # bottom tip of the heart
EDGE_L = 292                  # left edge of triangle base
EDGE_R = 732                  # right edge of triangle base
BRIDGE_TOP = 355              # top of the rect that fills the gap between lobes
BORDER = 24                   # thickness of the dark outline

# ── Helper ───────────────────────────────────────────────────────────────────
def draw_heart(draw, border=0, color=WHITE):
    b = border
    draw.ellipse([(LX-LR-b, LY-LR-b),(LX+LR+b, LY+LR+b)], fill=color)
    draw.ellipse([(RX-RR-b, RY-RR-b),(RX+RR+b, RY+RR+b)], fill=color)
    draw.rectangle([(EDGE_L-b, BRIDGE_TOP-b),(EDGE_R+b, BRIM_Y+b)], fill=color)
    draw.polygon([
        (EDGE_L-b,  BRIM_Y+b),
        (EDGE_R+b,  BRIM_Y+b),
        (512,       TIP_Y+b),
    ], fill=color)


def make_heart_mask():
    """White-on-black heart mask for alpha clipping."""
    m = Image.new('L', (SIZE, SIZE), 0)
    draw_heart(ImageDraw.Draw(m), color=255)
    return m


def build_icon(with_background: bool) -> Image.Image:
    img = Image.new('RGBA', (SIZE, SIZE), (0,0,0,0))
    draw = ImageDraw.Draw(img)

    # ── 1. Background (skip for foreground-only export) ──────────────────────
    if with_background:
        # Diagonal gradient (top-left: light, bottom-right: dark)
        import math
        for y in range(SIZE):
            t = y / (SIZE - 1)
            r = int(BG_TOP[0] + (BG_BOT[0]-BG_TOP[0])*t)
            g = int(BG_TOP[1] + (BG_BOT[1]-BG_TOP[1])*t)
            b = int(BG_TOP[2] + (BG_BOT[2]-BG_TOP[2])*t)
            draw.line([(0,y),(SIZE-1,y)], fill=(r,g,b,255))
        # Rounded-square clip
        mask = Image.new('L', (SIZE, SIZE), 0)
        ImageDraw.Draw(mask).rounded_rectangle(
            [(0,0),(SIZE-1,SIZE-1)], radius=210, fill=255)
        img.putalpha(mask)

    # ── 2. Dark outline (draw enlarged heart first) ───────────────────────────
    draw_heart(draw, border=BORDER, color=DARK)

    # ── 3. White heart body ───────────────────────────────────────────────────
    draw_heart(draw, border=0, color=WHITE)

    # ── 4. Hourglass triangles — clipped to heart ─────────────────────────────
    hg = Image.new('RGBA', (SIZE, SIZE), (0,0,0,0))
    hg_draw = ImageDraw.Draw(hg)
    # Upper pyramid: wide at top → narrows to waist
    hg_draw.polygon([(160,348),(864,348),(512,532)], fill=SAND+(255,))
    # Lower pyramid: waist → opens back to the heart's lower region
    hg_draw.polygon([(160,790),(864,790),(512,544)], fill=SAND+(255,))
    # Tiny white gap right at the waist to emphasise the pinch
    hg_draw.rectangle([(428,524),(596,540)], fill=WHITE+(255,))
    # Clip to heart shape
    hg.putalpha(make_heart_mask())
    img.alpha_composite(hg)

    # Re-grab draw after compositing
    draw = ImageDraw.Draw(img)

    # ── 5. Waist pinch bar ────────────────────────────────────────────────────
    draw.rounded_rectangle([(444,524),(580,548)], radius=12, fill=PINK)

    # ── 6. Sand dots falling through ─────────────────────────────────────────
    def dot(cx, cy, r, a):
        c = PINK + (int(255*a),)
        # draw on its own layer so partial alpha works
        lyr = Image.new('RGBA', (SIZE,SIZE),(0,0,0,0))
        ImageDraw.Draw(lyr).ellipse([(cx-r,cy-r),(cx+r,cy+r)], fill=c)
        img.alpha_composite(lyr)

    dot(512, 558, 10, 1.00)
    dot(496, 575,  8, 0.80)
    dot(528, 575,  8, 0.80)
    dot(512, 591,  6, 0.55)
    dot(499, 606,  4, 0.35)
    dot(525, 606,  4, 0.35)

    # ── 7. Tiny heart at waist — the "made with love" signature ───────────────
    def mini_heart(cx, cy, s, color, alpha):
        lyr = Image.new('RGBA', (SIZE,SIZE),(0,0,0,0))
        d   = ImageDraw.Draw(lyr)
        c   = color+(int(255*alpha),)
        hs  = s//2
        d.ellipse([(cx-s, cy-hs),(cx+2,  cy+hs)], fill=c)
        d.ellipse([(cx-2, cy-hs),(cx+s,  cy+hs)], fill=c)
        d.rectangle([(cx-s, cy-4),(cx+s, cy+hs)],  fill=c)
        d.polygon([
            (cx-s, cy+hs-4),
            (cx+s, cy+hs-4),
            (cx,   cy+s+4)
        ], fill=c)
        img.alpha_composite(lyr)

    mini_heart(512, 494, 26, (194, 24, 91), 0.50)

    return img


# ── Generate icon.png (full icon with background) ────────────────────────────
icon = build_icon(with_background=True)
path = os.path.join(DIR, 'icon.png')
icon.save(path, 'PNG')
print(f'icon.png saved  ({SIZE}x{SIZE})')

# ── Generate icon_foreground.png (transparent bg, for adaptive icon) ─────────
fg = build_icon(with_background=False)
fg_path = os.path.join(DIR, 'icon_foreground.png')
fg.save(fg_path, 'PNG')
print(f'icon_foreground.png saved  ({SIZE}x{SIZE})')
