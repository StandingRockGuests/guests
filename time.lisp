(in-package :guests)

(defun render-time (stream)
  (comment
   "
After the winter solstice
=========================

Old Moon, or Moon After Yule
Snow Moon, Hunger Moon, or Wolf Moon
Sap Moon, Crow Moon or Lenten Moon

After the spring equinox
========================

Grass Moon, or Egg Moon
Planting Moon, or Milk Moon
Rose Moon, Flower Moon, or Strawberry Moon

After the summer solstice
=========================

Thunder Moon, or Hay Moon
Green Corn Moon, or Grain Moon
Fruit Moon, or Harvest Moon

After the autumnal equinox
==========================

Harvest Moon, or Hunter’s Moon
Hunter’s Moon, Frosty Moon, or Beaver Moon
Moon Before Yule, or Long Night Moon

" :indent 4)
  (header-panel :mode "seamed"
    (toolbar :class "time"
      (:span :style "margin-left:0px;" :class "title" "The Time")
      (icon-button :class "toolbar-icon" :style "margin-left:0px;" :icon "arrow-back" :onclick "page(\"/\");"))
    (:div :style "padding:20px;" :class "fit layout vertical center-justified"
          (:center
           (:div :id "time")
           (:div :id "moon")))))

(in-package :story-js)

(define-script moontime
  (defun update-time ()
    (let* ((now (new (*date)))
           (pos (moon-position now))
           (ill (moon-illumination now)))
      (story-js:set-html* "time" (format-time now))
      (story-js:set-html* "moon"
                          (:table
                           (:tr (:th "altitude") (:td (round (rad-to-deg (@ pos altitude)))))
                           (:tr (:th "azimuth") (:td (round (rad-to-deg (@ pos azimuth)))))
                           (:tr (:th "distance") (:td (round (@ pos distance))))
                           (:tr (:th "fraction") (:td (@ ill fraction)))
                           (:tr (:th "phase") (:td (@ ill phase)))
                           (:tr (:th "angle") (:td (rad-to-deg (@ ill angle)))))))))
