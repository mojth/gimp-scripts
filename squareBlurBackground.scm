;https://github.com/mojth/gimp-scripts.git
(define 
 (script-fu-square-blur-background image blur)
 (gimp-image-undo-group-start image)
 (gimp-context-push)
 (let*
  (
   (width (car (gimp-image-width image)))
   (height (car (gimp-image-height image)))
   (size (highValue width height))
   (offx (/ (- size width) 2))
   (offy (/ (- size height) 2))
   (background (car(gimp-layer-new-from-visible image image "background")))
   (scaleWidth (* size (/ size height)))
   (scaleHeight (* size (/ size width)))
  )
  (gimp-image-add-layer image background 0)
  (gimp-image-lower-layer-to-bottom image background)
  (gimp-image-resize image size size offx offy)
  (gimp-layer-scale background scaleWidth scaleHeight TRUE)
  (plug-in-gauss RUN-NONINTERACTIVE image background blur blur 0)
 )
 (gimp-context-pop)
 (gimp-image-undo-group-end image)
 (gimp-displays-flush)
)

(define (highValue a b) (if (> a b) a b))

(script-fu-register
 "script-fu-square-blur-background"
 "<Image>/Image/square blur backgruond"
 "Create a blur background with equal width and height. The background is created by bluring all visible layers."
 "Thomas Moj"
 ""
 "2020-11-01"
 "RGB*"
 SF-IMAGE "Image" 0
 SF-ADJUSTMENT "Blur" '(100 0 500 1 10 0 0)
)
