#!/usr/bin/env python3
"""Генерирует ночной фон Турина (NightTurin.jpg) в том же тёмном стиле
«ясной европейской ночи», что и остальные города путеводителя: глубокое
синее небо со звёздами, тёплое зарево над городом, силуэт крыш с окнами,
альпийский задник и узнаваемая Моле-Антонеллиана с высоким шпилем.

Не фотография, а стилизованный фон под общий дизайн приложения.
Запуск: scripts/turinvenv/bin/python scripts/generate_turin_bg.py
"""

import math
import random

from PIL import Image, ImageDraw, ImageFilter

W, H = 1400, 1050
random.seed(1861)  # год объединения Италии со столицей в Турине

HORIZON = 690  # линия крыш


def lerp(a, b, t):
    return tuple(int(a[i] + (b[i] - a[i]) * t) for i in range(3))


def main():
    img = Image.new("RGB", (W, H))
    px = img.load()

    sky_top = (9, 17, 34)      # почти чёрный синий в зените
    sky_mid = (23, 33, 58)     # ночная синь
    sky_low = (58, 44, 60)     # тёплая дымка у горизонта
    glow = (150, 96, 70)       # зарево городских огней

    # Небо: двойной вертикальный градиент + мягкое зарево над городом.
    for y in range(H):
        if y < HORIZON:
            t = y / HORIZON
            base = lerp(sky_top, sky_mid, t) if t < 0.6 else lerp(sky_mid, sky_low, (t - 0.6) / 0.4)
        else:
            base = sky_low
        for x in range(W):
            r, g, b = base
            # тёплое зарево, сгущающееся к линии крыш и к центру кадра
            d = abs(y - HORIZON)
            halo = max(0.0, 1 - d / 340) * max(0.35, 1 - abs(x - W * 0.52) / (W * 0.75))
            halo *= 0.55
            r = min(255, int(r + (glow[0] - r) * halo))
            g = min(255, int(g + (glow[1] - g) * halo))
            b = min(255, int(b + (glow[2] - b) * halo))
            px[x, y] = (r, g, b)

    draw = ImageDraw.Draw(img, "RGBA")

    # Звёзды в верхней половине неба.
    for _ in range(230):
        x = random.randint(0, W - 1)
        y = random.randint(0, int(HORIZON * 0.72))
        fade = 1 - y / (HORIZON * 0.72)
        a = int(random.randint(60, 190) * (0.4 + 0.6 * fade))
        r = random.choice([0, 0, 0, 1])
        draw.ellipse([x - r, y - r, x + r, y + r], fill=(255, 246, 224, a))

    # Альпы на заднем плане — ломаная тёмная линия чуть выше крыш.
    ridge = HORIZON - 70
    pts = [(0, ridge)]
    x = 0
    while x < W:
        x += random.randint(60, 130)
        pts.append((min(x, W), ridge - random.randint(-8, 78)))
    pts += [(W, HORIZON), (0, HORIZON)]
    draw.polygon(pts, fill=(18, 22, 40, 255))

    # Силуэт городских крыш: ряд зданий разной высоты с тёплыми окнами.
    x = -20
    while x < W + 20:
        w = random.randint(46, 104)
        h = random.randint(70, 190)
        top = HORIZON - h
        draw.rectangle([x, top, x + w, H], fill=(10, 12, 22, 255))
        # окна
        for wy in range(top + 12, H - 8, 22):
            for wx in range(x + 8, x + w - 8, 18):
                if random.random() < 0.32:
                    a = random.randint(120, 235)
                    col = random.choice([(255, 208, 130), (255, 190, 96), (240, 220, 170)])
                    draw.rectangle([wx, wy, wx + 6, wy + 9], fill=(*col, a))
        x += w + random.randint(-6, 10)

    # Моле-Антонеллиана — доминанта Турина.
    cx = int(W * 0.40)
    base_w = 150
    base_h = 150
    base_top = HORIZON - base_h
    body = (7, 9, 18, 255)
    draw.rectangle([cx - base_w // 2, base_top, cx + base_w // 2, HORIZON], fill=body)
    # колоннадный «храмик» — сужающаяся трапеция
    t_h = 120
    t_top = base_top - t_h
    draw.polygon([(cx - 58, base_top), (cx + 58, base_top),
                  (cx + 34, t_top), (cx - 34, t_top)], fill=body)
    # купол-основание шпиля
    dome_h = 60
    dome_top = t_top - dome_h
    draw.polygon([(cx - 34, t_top), (cx + 34, t_top),
                  (cx + 12, dome_top), (cx - 12, dome_top)], fill=body)
    # высокий тонкий шпиль (агулья)
    spire_top = dome_top - 210
    draw.polygon([(cx - 12, dome_top), (cx + 12, dome_top),
                  (cx + 2, spire_top), (cx - 2, spire_top)], fill=body)
    # звезда на вершине
    draw.ellipse([cx - 4, spire_top - 4, cx + 4, spire_top + 4], fill=(255, 236, 190, 255))
    # подсветка тела Моле тёплым светом
    for wy in range(base_top + 16, HORIZON - 10, 20):
        for wx in range(cx - base_w // 2 + 12, cx + base_w // 2 - 10, 20):
            if random.random() < 0.5:
                a = random.randint(120, 220)
                draw.rectangle([wx, wy, wx + 5, wy + 8], fill=(255, 205, 140, a))

    # Лёгкая дымка над кварталами.
    haze = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    hd = ImageDraw.Draw(haze)
    for i in range(3):
        y = HORIZON - 20 + i * 12
        hd.rectangle([0, y, W, y + 26], fill=(150, 110, 90, 22))
    haze = haze.filter(ImageFilter.GaussianBlur(18))
    img = Image.alpha_composite(img.convert("RGBA"), haze).convert("RGB")

    # Мягкость + лёгкое зерно, чтобы не было полос градиента.
    img = img.filter(ImageFilter.GaussianBlur(0.6))
    grain = img.load()
    for _ in range(60000):
        x = random.randint(0, W - 1)
        y = random.randint(0, H - 1)
        r, g, b = grain[x, y]
        n = random.randint(-6, 6)
        grain[x, y] = (max(0, min(255, r + n)), max(0, min(255, g + n)), max(0, min(255, b + n)))

    out = "TripGuide/Assets.xcassets/NightTurin.imageset/NightTurin.jpg"
    img.save(out, "JPEG", quality=88)
    print(f"Записан {out} ({W}x{H})")


if __name__ == "__main__":
    main()
