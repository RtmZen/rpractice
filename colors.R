filePath <- paste(c(R.home(), "/etc/rgb.txt"), collapse = "")
classList <- c("factor", "NULL", "character")
colorRaw <- read.table(file = filePath,
                       quote = "\"'",
                       colClasses = classList,
                       skip = 1)
names(colorRaw) <- c("COLOR", "RGB")

rgb <- sapply(strsplit(colorRaw$RGB,
                       split = "\\,"),
              "[",
              1:3)
r <- as.numeric(sapply(strsplit(rgb[1, ],
                                split = "\\{"),
                       "[",
                       2))
g <- as.numeric(rgb[2,])
b <- as.numeric(sapply(strsplit(rgb[3, ],
                                split = "\\}"),
                       "[",
                       1))

RGBtoHEX <- function(rgb = c(0, 0, 0)) {
   if(length(rgb) == 3) {
      if (is.vector(rgb, mode = "numeric")) {
         paste(c("#", sprintf("%-0.2X", rgb)), collapse = "")
         }
      else stop("Incorrect input!")
      }
   else stop("Incorrect input!")
}

hex <- sapply(as.list(rbind.data.frame(r, g, b)), RGBtoHEX)

colorData <- data.frame("COLOR"   = colorRaw$COLOR,
                        "R"       = r,
                        "G"       = g,
                        "B"       = b, 
                        "HEX"     = hex,
                        row.names = NULL)

library(scatterplot3d)

with(colorData, {
   scatterplot3d(x           = 100 * R / 255,
                 y           = 100 * G / 255,
                 z           = 100 * B / 255,
                 color       = colorData$COLOR,
                 pch         = 20,
                 main        = "Colors from rgb.txt",
                 sub         = "comment",
                 xlim        = c(0, 100),
                 ylim        = c(0, 100),
                 zlim        = c(0, 100),
                 xlab        = "Green",
                 ylab        = "Red",
                 zlab        = "Blue",
                 type        = "h",
                 scale.y     = 0.9,
                 angle       = 225,
                 x.ticklabs  = c(0, 51, 102, 153, 204, 255),
                 y.ticklabs  = c(0, 51, 102, 153, 204, 255),
                 z.ticklabs  = c(0, 51, 102, 153, 204, 255),
                 font.lab    = 1,
                 cex.symbols = par("cex"),
                 cex.axis    = 0.7 * par("cex.axis"),
                 cex.lab     = 0.9 * par("cex.lab"),
                 lty.hplot   = 1)
}
)
