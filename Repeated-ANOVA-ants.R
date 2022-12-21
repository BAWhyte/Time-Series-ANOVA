### Statistical tests for Jessica ###
# OUTLINE:
# 1) Set up + clean up
# 2) T test for each TimePoint in each data set
# 3) Summarize data and plot line graph w/ error bars 
### - - - - - - - - - - - - - - - ###

# BLOCK 0: Set up + clean up ----------------------------------------------------------------------

## Housekeeping (clears variables, console and plots)
cat("\014") # Clear console
rm(list=ls()) # Remove all variables 
## Load packages
library(ggplot2) # for ribbon plots
library(ggpubr) # for combining ggplots with ggarrange()
library(patchwork) # for arranging graphs
library(dplyr) # for data frame transformations
library(tidyr) # for data frame transformations
library(stargazer) # for lm table outputs
## Upload data
data <- read.csv("Data.csv")
#

# BLOCK 1: Ribbon plot version of line graphs -----------------------------------------------------

## HabS
## Grooming (gGROM)
{ # START sub-section - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  dfGROM <- data_frame(df$Trial, df$Condition, df$Grooming, df$TimePoint)
  colnames(dfGROM) <- c("Trial","Condition","GROM","TP")
  dfGROM <- dfGROM %>%
    group_by(TP, Condition) %>%
    summarize(avg = mean(GROM), sd= sd(GROM)) # transform into columns of mean and sd, with group ID as neighboring column
  dfGROM[,"SEmin"] <- dfGROM$avg - dfGROM$sd/sqrt(10) # standard error minimum
  dfGROM[,"SEmax"] <- dfGROM$avg + dfGROM$sd/sqrt(10) # standard error maximum
  dCON <- dfGROM[dfGROM$Condition == "CON",] # CON only (for ribbon)
  dEXP <- dfGROM[dfGROM$Condition == "EXP",] # EXP only (for ribbon)
  ## Line graph with ribbon plot and line of best fit
  gGROM <- ggplot(dfGROM, aes(x = TP, y = avg, color = Condition, group = Condition)) +
    theme_bw() +
    theme(legend.position="none") +
    theme(text=element_text(family = "serif")) +
    theme(axis.text.x = element_text(size = 10)) +
    theme(axis.text.y = element_text(size = 10)) +
    theme(axis.title.x = element_blank()) +
    ggtitle("Grooming (GROM)") +
    theme(plot.title = element_text(hjust = 0.5)) +
    annotate("text", x=2, y=18, label="bold(A)", size=3.5, parse=TRUE) +
    annotate("text", x=3.5, y=0, label="italic(Short-interval)", size=3, parse=TRUE, family = "serif") +
    geom_ribbon(data=dCON, aes(x = TP, ymin = SEmin, ymax = SEmax), inherit.aes=FALSE, fill="grey90", alpha=.35) +
    geom_ribbon(data=dEXP, aes(x = TP, ymin = SEmin, ymax = SEmax), inherit.aes=FALSE, fill="grey90", alpha=.35) +
    geom_line(linetype=2, size=.8) +
    geom_point(aes(shape = Condition), size=3) +
    geom_smooth(method="lm", se=FALSE, lwd=1.2) +
    scale_color_manual(values=c("gray60", "gray0")) +
    scale_x_continuous(breaks = c(2,4,6,8)) +
    ylim(0,18) +
    xlab("Time Point") +
    ylab("# of grooming events")
  # END sub-section - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
}

## Antenation frequency (gAF)
{ # START sub-section - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  dfAF <- data_frame(df$Trial, df$Condition, df$AEO, df$TimePoint)
  colnames(dfAF) <- c("Trial","Condition","AF","TP")
  dfAF <- dfAF %>%
    group_by(TP, Condition) %>%
    summarize(avg = mean(AF), sd= sd(AF)) # transform into columns of mean and sd, with group ID as neighboring column
  dfAF[,"SEmin"] <- dfAF$avg - dfAF$sd/sqrt(10) # standard error minimum
  dfAF[,"SEmax"] <- dfAF$avg + dfAF$sd/sqrt(10) # standard error maximum
  dCON <- dfAF[dfAF$Condition == "CON",] # CON only (for ribbon)
  dEXP <- dfAF[dfAF$Condition == "EXP",] # EXP only (for ribbon)
  ## Line graph with ribbon plot and line of best fit
  gAF <- ggplot(dfAF, aes(x = TP, y = avg, color = Condition, group = Condition)) +
    theme_bw() +
    theme(legend.position="none") +
    theme(axis.title.x = element_blank()) +
    theme(axis.text.x = element_text(size = 10)) +
    theme(axis.text.y = element_text(size = 10)) +
    theme(text=element_text(family = "serif")) +
    ggtitle("Antennation freq. (AF)") +
    theme(plot.title = element_text(hjust = 0.5)) +
    annotate("text", x=2, y=42, label="bold(B)", size=3.5, parse=TRUE) +
    #annotate("text", x=3, y=0, label="italic(Hab-Short)", size=2.8, parse=TRUE) +
    geom_ribbon(data=dCON, aes(x = TP, ymin = SEmin, ymax = SEmax), inherit.aes=FALSE, fill="grey90", alpha=.35) +
    geom_ribbon(data=dEXP, aes(x = TP, ymin = SEmin, ymax = SEmax), inherit.aes=FALSE, fill="grey90", alpha=.35) +
    geom_line(linetype=2, size=.8) +
    geom_point(aes(shape = Condition), size=3) +
    geom_smooth(method="lm", se=FALSE, lwd=1.2) +
    scale_color_manual(values=c("gray60", "gray0")) +
    scale_x_continuous(breaks = c(2,4,6,8)) +
    ylim(0,42) +
    xlab("Time Point") +
    ylab("# of nestmate antennation events")
  # END sub-section - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
}

## Antennal raising (gAR)
{ # START sub-section - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  dfAR <- data_frame(df$Trial, df$Condition, df$AR, df$TimePoint)
  colnames(dfAR) <- c("Trial","Condition","AR","TP")
  dfAR <- dfAR %>%
    group_by(TP, Condition) %>%
    summarize(avg = mean(AR), sd= sd(AR)) # transform into columns of mean and sd, with group ID as neighboring column
  dfAR[,"SEmin"] <- dfAR$avg - dfAR$sd/sqrt(10) # standard error minimum
  dfAR[,"SEmax"] <- dfAR$avg + dfAR$sd/sqrt(10) # standard error maximum
  dCON <- dfAR[dfAR$Condition == "CON",] # CON only (for ribbon)
  dEXP <- dfAR[dfAR$Condition == "EXP",] # EXP only (for ribbon)
  ## Line graph with ribbon plot and line of best fit
  gAR <- ggplot(dfAR, aes(x = TP, y = avg, color = Condition, group = Condition)) +
    theme_bw() +
    theme(axis.title.x = element_blank()) +
    theme(axis.text.x = element_text(size = 10)) +
    theme(axis.text.y = element_text(size = 10)) +
    theme(text=element_text(family = "serif")) +
    ggtitle("Antennal raising (AR)") +
    theme(plot.title = element_text(hjust = 0.5)) +
    annotate("text", x=2, y=9.7, label="bold(C)", size=3.5, parse=TRUE) +
    #annotate("text", x=3, y=0, label="italic(Hab-Short)", size=2.8, parse=TRUE) +
    geom_ribbon(data=dCON, aes(x = TP, ymin = SEmin, ymax = SEmax), inherit.aes=FALSE, fill="grey90", alpha=.35) +
    geom_ribbon(data=dEXP, aes(x = TP, ymin = SEmin, ymax = SEmax), inherit.aes=FALSE, fill="grey90", alpha=.35) +
    geom_line(linetype=2, size=.8) +
    geom_point(aes(shape = Condition), size=3) +
    geom_smooth(method="lm", se=FALSE, lwd=1.2) +
    scale_color_manual(values=c("gray60", "gray0")) +
    scale_x_continuous(breaks = c(2,4,6,8)) +
    ylim(0,9.7) +
    xlab("Time Point") +
    ylab("# of antennal raising events")
  # END sub-section - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
}

## Patchwork the graphs together + print
gHabL <- gGROM + gAF + gAR

tiff("Graphs.tiff", units="in", width=9, height=6.5, res=600)
# insert ggplot code
gHabS
dev.off()

# BLOCK 2: Repeated Measure ANOVA for each behavior -------------------------------------------------------

aovGROM <- aov(GROM ~ Condition * TimePoint + Error(Trial)) # Grooming
aovAF <- aov(AF ~ Condition * TimePoint + Error(Trial)) # Antennation frequency
aovAR <- aov(AR ~ Condition * TimePoint + Error(Trial)) # Antennal raising

summary(aovGROM)
summary(aovAF)
summary(aovAR)
#

