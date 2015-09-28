class @CurveArrow
  constructor: (@canvas)->
    # nothing

  draw: (x0, y0, x1, y1, color)->
    # console.log '绘制曲线箭头', [x0, y0], [x1, y1]

    ctx = @canvas.getContext '2d'
    ctx.fillStyle = color
    ctx.strokeStyle = color
    ctx.lineWidth = 2
    ctx.lineCap = 'round'

    ctx.beginPath()
    ctx.moveTo x0, y0
    ctx.lineTo x1, y1
    ctx.stroke()

    # 画箭头
    xp = (x0 + x1) / 2
    yp = (y0 + y1) / 2
    ang = Math.atan (y0 - y1) / (x0 - x1)
    ang += Math.PI if x1 > x0

    # 箭头侧翼长度
    hx = 10
    ctx.lineWidth = 2
    ctx.save()
    ctx.translate xp, yp
    ctx.rotate ang
    ctx.beginPath()
    ctx.moveTo 0, 0
    ctx.lineTo hx, hx / 1.5
    ctx.lineTo hx / 2, 0
    ctx.lineTo hx, -hx / 1.5
    ctx.lineTo 0, 0
    ctx.fill()
    ctx.restore()