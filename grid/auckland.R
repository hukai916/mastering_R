library(lattice)
library(grid)
xyplot(mpg ~ disp, mtcars, main="Fast Cars")

# Q1: What is the name of the grob that represents the main title on the scatterplot ?
# Solution: plot_01.main
showGrob(just="right", gp = gpar(col= "green", cex=1)) # labels each grob

# Q2: What is the name of the viewport that the main title is drawn within ?
# Solution: plot_01.main.vp
showViewport()
grid.ls(viewports = TRUE, grobs = FALSE, fullNames = TRUE)
current.vpTree() # need to use formatVPTree() to tidy up

# P1: remove the border of the plot
library(lattice)
barchart(Party ~ Amount_Donated, sortedTotals)
# Solution: first find the names of the grobs to be removed with showGrob(), then grid.remove() to remove them.

# Q3-Q4
library(lattice)
xyplot(mpg ~ disp, mtcars, main="Fast Cars")

# Q3: Change the colour of the main title to red.
showGrob(just = "left", gp = gpar(col= "green", cex=1))
grid.edit("plot_01.main", gp = gpar(col = "green"))

# Q4: Remove the main title from the plot.
grid.remove("plot_01.main")

# Q5: Navigate to the viewport that the main title was drawn in and draw a rectangle to show that you are in the right place.
# showViewport()
current.vpTree()
downViewport("plot_01.main.vp")
grid.rect(gp = gpar(col = "blue", fill = "blue"))

# Q5
library(lattice)
xyplot(mpg ~ disp, mtcars, main="Fast Cars")

# Q5: Navigate to the viewport that the data symbols were drawn in and draw a horizontal line at mpg == 25. Draw a label just above and to the right of the symbol for the "Pontiac Firebird" (disp=400, mpg=19.2).
current.vpTree()
downViewport("plot_01.panel.1.1.vp")
grid.lines(y = unit(25, "native"))
grid.text("Pontiac Firebird", 
          x = unit(405, "native"), 
          y = unit(20, "native"), 
          just = c("left", "bottom"))

# Q6
library(lattice)
xyplot(mpg ~ disp, mtcars, main="Fast Cars")
# Q6: Create a viewport in the bottom-right quarter of the page and draw the plot in that viewport.

grid.newpage()
vp = viewport(width = 0.5, height = 0.5, x = 0.5, y = 0, just = c("left", "bottom"))
pushViewport(vp)
print(xyplot(mpg ~ disp, mtcars, main="Fast Cars"), newpage = FALSE)

# Q7
library(ggplot2)
qplot(disp, mpg, data=mtcars, main="Fast Cars")
# Q7: 
# 7-1 Navigate to the viewport that the main title was drawn in and draw a rectangle to show the extent of the viewport.
# 7-2 Edit the title grob to move it to the right-hand edge of the plot.
# 7-3 Remove the rectangle that you just drew.
grid.force()
grid.ls(viewports = TRUE, fullNames = TRUE)
# showViewport()
downViewport("title.3-7-3-7")
grid.rect(gp = gpar(col=NA, fill=rgb(0,1,0,.5)), name = "test1")
#showGrob()
#showGrob(depth = 0)
grid.edit("GRID.text.8664", 
          gp = gpar(col = "black"),
          x = unit(1, "npc") - unit(stringWidth("Fast Cars"), "npc"),
          y = unit(0.8, "npc"))
grid.remove("test1")

# Q8
plot(mpg ~ disp, mtcars, pch=16, main="Fast Cars")

# Q8: Convert the plot to an identical 'grid' plot, change the title to red.Remove the title.
library(gridGraphics)
grid.echo()
grid.ls()
grid.edit("graphics-plot-1-main-1", gp = gpar(col = "red"))
grid.remove("graphics-plot-1-main-1")

# Q9
# Produce a layout like the diagram below.
#   +-----------------------------------------+ 
#   |         w=7/9      5    h=0.5/5.5       |
#   +-----+-----------------------------+-----+
#   |     |              1    h=1.0/5.5 |     |
#   |     +-----------------------------+     |
#   |  6  |              2    h=1.0/5.5 |  7  |
#   |     +-----------------------------+     |
#   |w=1/9|              3    h=1.0/5.5 |w=1/9|
#   |     +-----------------------------+     |
#   |     |                             |     |
#   |     |              4    h=2.0/5.5 |     |
#   |     |                             |     |
#   +-----+-----------------------------+-----+
widths <- unit(c(1, 7, 1), c("null", "null", "null"))
heights <- unit(c(0.5, 1, 1, 1, 2), c("null", "null", "null", "null", "null"))

lay <- grid.layout(5, 3, widths = widths, heights = heights)
# vplay <- viewport(layout=lay)
grid.show.layout(lay)

# Q9
grid.newpage()
grid.text("label 1", 1/3, 2/3, name="l1")
grid.text("label two", 2/3, 1/3, name="l2")

# Q9: Draw a circle around each piece of text (with a radius that is half of the width of the text, plus 1mm). Draw a line from the bottom-right edge of the top-left circle to the top-left edge of the bottom-right circle.
grid.circle(x = grobX("l1", 90), y = grobY("l1", 0), r = grobWidth("l1")/2 + unit(1, "mm"), gp = gpar(col = "black", fill = NA))
grid.circle(x = grobX("l2", 90), y = grobY("l2", 0), r = grobWidth("l2")/2 + unit(1, "mm"), gp = gpar(col = "black", fill = NA))

bottom_right_x <- grobX("l1", 90) + (grobWidth("l1")/2 + unit(2, "mm")) / sqrt(2)
bottom_right_y <- grobY("l1", 90) - (grobWidth("l1")/2 + unit(2, "mm")) / sqrt(2)
top_left_x <- grobX("l2", 90) - (grobWidth("l1")/2 + unit(2, "mm")) / sqrt(2)
top_left_y <- grobY("l2", 90) + (grobWidth("l1")/2 + unit(2, "mm")) / sqrt(2)

grid.segments(x0 = bottom_right_x, y0 = bottom_right_y,ewp
              x1 = top_left_x, y1 = top_left_y)

# Q10
library(lattice)
xyplot(jitter(Sepal.Length) ~ jitter(Sepal.Width),
       group=Species, iris,
       par.settings=list(
         superpose.symbol=list(pch=21,
                               col="black",
                               fill="grey")))
# Q10: Blur all of the points except for the "setosa" variety (hint: there are three separate points grobs in the plot, one for each variety).
library(gridSVG)
grid.ls()
grid.filter("plot_01.xyplot.points.group.2.panel.1.1", filterEffect(feGaussianBlur(sd = 1)))
grid.filter("plot_01.xyplot.points.group.1.panel.1.1", filterEffect(feGaussianBlur(sd = 1)))
grid.export("Q10_blurred.svg")
