;https://github.com/mojth/gimp-scripts.git
(define 
 (script-fu-shadow-on-separate-layer image size feather opacity)
 (gimp-image-undo-group-start image)
 (gimp-context-push)
 (gimp-image-select-item image CHANNEL-OP-REPLACE (car(gimp-image-get-active-layer image)))
 (gimp-selection-grow image size)
 (gimp-selection-feather image feather)
 (gimp-context-set-background '(0 0 0))
 (let* (
   (width (car(gimp-image-width image)))
   (height (car(gimp-image-height image)))
   (shadow (car(gimp-layer-new image width height RGBA-IMAGE "shadow" opacity LAYER-MODE-NORMAL)))
  )
  (gimp-image-add-layer image shadow (car(gimp-image-get-item-position image (car(gimp-image-get-active-layer image)))))
  (gimp-image-lower-item image shadow)
  (gimp-edit-fill shadow FILL-BACKGROUND) 
 )
 (gimp-context-pop)
 (gimp-image-undo-group-end image)
 (gimp-displays-flush)
)

(script-fu-register
 "script-fu-shadow-on-separate-layer"
 "<Image>/Filters/Light and Shadow/shadow on separte layer"
 "Create a shadow for the currently active layer on a saparate Layer"
 "Thomas Moj"
 ""
 "2020-11-14"
 "RGB*"
 SF-IMAGE "Image" 0
 SF-ADJUSTMENT "size" '(5 0 50 1 10 0 0)
 SF-ADJUSTMENT "feather" '(5 0 50 1 10 0 0)
 SF-ADJUSTMENT "opacity" '(80 0 100 1 10 0 0)
)
