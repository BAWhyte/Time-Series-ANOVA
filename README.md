# Time-Series-ANOVA
*This work has been [published here](https://www.mdpi.com/2075-4450/11/12/871/htm), and this repository simply highlights one method used in this project that is likely useful for many other behavioral experiments*

## Reduced response to a cue overtime
When ants release an alarm pheromone, other nearby ants smell it and become alarmed, moving faster, scattering in every direction, and fighting any threat they notice. Sometimes, other ants release alarm pheromone during this as well, causing even more alarming signal to be sent throughout the group. Surely this does not positively feedback, or else ants would stay alarmed forever after being alarmed once. But when do they stop reacting to the alarming signal? In other words, this is a "boy who cried wolf" story, where at some point the alarm call becomes unreliable and ignored. 

We noticed the following pattern in some behaviors we could measure in our ants:

![Fig4_ReducedResponse](https://user-images.githubusercontent.com/15988774/209018266-607fd3f0-22b6-421e-a5ff-ca79fed20524.png)

Each point on these black "EXP" lines is a measurement shortly after a group of ants was exposed to alarm pheromone from their nestmates. Each point on the gray "CON" lines are measurements from the control group, where no alarm pheromone was introduced. While the slopes of these EXP and CON lines seem to change, we need to be certain there are differences in behaviors between the two groups recorded at each time point. 

To do this, we cannot just do a regular ANOVA, as our data samples from the same group of indivdual multiples times (4 times) over the course of the experiment. By using a repeated measures analysis of variance (ANOVA) instead, we can test the interaction of condition groups and timepoints and a between-trial effect (Model = Behavior ~ Condition × Timepoint + Error (Trial)). The between-trial effect tests tells us if the condition groups showed significantly different behaviors between trials, while the within-trial effect tests if the condition groups showed significantly different behavioral changes over timepoints. 

Since all of the tests showed a significant interaction between Condition:Timepoint within trials, this means the behaviors were significantly different across the total time they were recorded in our experiments when comparing the control group behaviors to the experimental group behaviors. 

![Table1_All](https://user-images.githubusercontent.com/15988774/209024013-e58dd0cc-97ce-4a21-a353-edfa546d8a02.png)

