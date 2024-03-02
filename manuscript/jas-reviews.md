## Comments from the editors and reviewers:

### Reviewer #1

I will begin by stating that I do think the idea of creating prehistoric
versions of Metropolitan Statistical Areas by defining walking-time-catchments
is novel and analytically useful. With that said, the authors made a significant
error in one of their most fundamental calculations and that error was repeated
thousands or perhaps millions of times as they built up the data they required
for their analyses. To make matters worse, the errors compound because the
higher-level method that relies on the calculation, least cost graph search, is
designed to estimate overall travel time from origins to destinations by
repeatedly adding up the calculated values on a per-node/edge basis to find
efficient routes. The error they made is in the calculation of cost (travel
time) between individual nodes, which is expressed in their code as: g\\\$cost
\<- g\\\$run/g\\\$speed. They are using the horizontal distance between nodes
(run) instead of the actual three-dimensional distance traveled, a.k.a., the
hypotenuse of the triangle, which we know to be: sqrt(run*run + rise*rise). In
perfectly flat terrain, the horizontal and three-dimensional values would be
identical, but the Mesa Verde region is not in any way perfectly flat, so the
actual distance traveled is longer than what they are using right now. Based on
this one mistake alone, I would recommend either an immediate rejection of the
manuscript or an invitation to resubmit after substantial revisions are made.
The authors essentially have to start over and regenerate all of their data and
all of their analyses because everything they do depends on travel time
estimates that are currently incorrect. It's all fruit of a poisoned tree, and
it saddens me to write that because I know that redoing it all will take time
and could fundamentally alter their conclusions. I am heavily leaning towards
the invitation to revise because of the manuscript's novelty, but there are
three other significant issues that they will need to address if they do so.

First, the choice of using the first decile for Campbell's equation is odd, and
unexplained. Campbell specifically recommends that for the highest accuracy and
consistency with available ground truth datasets and other well-documented
studies, only the 5th percentile for the Lorentz function should be used. Using
the 10th definitely speeds up travelers so they can cover more ground and that
in turn leads to the inclusion of more sites in communities, but I don't
currently see a solid basis in the manuscript for doing that. The authors should
also specify in the main text which variant of Campbell they are using: Laplace,
Gauss, or Lorentz. I can tell from their code that it's the third one, but I had
to dig for that. They also made a mistake in terms of referencing the wrong
coefficients table from Campbell's Supplementary Data. It should be S3, not S1.
The coefficients they use in their code are the correct ones, but I had to
consult Campbell's original data tables to confirm that.

Second, there are two concerning computational compromises, and neither of them
is really justifiable except for the case where the authors had to conduct their
data generation and analysis on an extremely low-performance laptop, they were
using extremely inefficient software libraries, or both. It starts with their
downsampling of the elevation model from 30m to 100m, which is almost an order
of magnitude (9x because it's a factor of 3 in both grid directions) reduction
in data size and quality for the sake of not having to deal with something
bigger...because their analyses would then take longer. They do not specify how
they did the reduction (averaged original value in each cell? max original
value?) and that raises additional questions about the validity of their least
cost analyses (putting aside the fundamental math error discussed above) because
you have far fewer data values to work with over much larger areas, so each one
counts a great deal more. If you do the reduction wrong, you could end up
introducing a wide variety of errors...which then propagate into everything else
down the line. Next is the use of a bidirectional Dijkstra function instead of
the standard approach of running full Dijkstra twice (origin-\>destination,
destination-\>origin) when they are establishing travel times between sites. It
does cut the runtime in half since you are executing it from the origin and
destination simultaneously and it stops when the two searches bump into each
other, which is exactly why they selected it (time savings) because they wanted
to run it for a relatively large number of site pairings, but you lose
anisotropic accuracy as a result. The authors state that they don't believe
these two decisions (elevation data reduction and shortcutting Dijkstra) will
have a significant impact on their analyses, but that's a belief which isn't
currently backed up by any supporting evidence.

Third, the methodology they use to define the statistical areas strikes me as
overly complicated and messy. It sort of works, but I'm left wondering why they
didn't employ readily-available tools to do something more straightforward and
clean instead of trying to deconflict boundaries by using concave hulls based on
least cost path extents. Upon reading the manuscript, my first question along
these lines was why they didn't do the following:

1)  Create a least cost surface based on Campbell's equation that incorporates
    all of the community centers as origins for travel. The result would be
    something that looks like an elevation map (but representing travel time)
    with basins closest to the centers and ridges where searches from each
    center run into each other. Yes, I know that this recommendation is
    different than what I discuss in my second point above, but hang in there,
    there's a reason that I'm recommending it. It's about establishing
    non-overlapping regions without resorting to clustering algorithms.

2)  Run the least cost surface through a hydrological analysis tool to define
    non-overlapping catchments (time instead of water), then vectorize the
    output into polygons. The result would be akin to a Voronoi diagram of the
    centers, but based on travel time. You could also do a contour analysis
    based on maximum permitted travel time from each center to modify the
    polygons. Some polygons will stay the same because they fall within the
    contour, but others might shrink a bit because it takes longer than the
    permitted time to reach the boundary with adjacent polygons.

3)  Intersect the polygons with all of the site points to establish community
    membership, then start removing sites based on how long it takes to reach
    them (referencing the cost surface grid cell values they are sitting on top
    of), if necessary. Although the contour analysis mentioned in #2 would also
    take care of that since the polygons would only contain valid sites.

4)  Run other analyses as needed, to include anisotropic site-to-site path
    searches.

I want to see this manuscript succeed, but it definitely needs a lot of work at
the methodological level. If the authors run into any challenges with trying the
above four steps, to include slowdowns due to the size of the input datasets, I
would be happy to provide assistance in the form of subject matter expertise
and/or data processing.

### Reviewer #2

Summary: This paper, titled "A method for defining dispersed community
territories" provides a geospatial approach to defining communities based on
aggregation, distance (time), and size of houses and community centers with a
case study from three regions in the US SW. The authors use a robust dataset of
nearly 800 centers to define communities. This paper provides clear, step by
step instructions for how to conduct a similar analysis in any study area with
the R markdown code provided in the online supplemental materials; this will
allow replicability of their methods by archaeologists working in any context.
Nonetheless, there are three key areas that I think can be improved before this
paper moves towards publication. First, additional citations are needed to
support some of the assumptions and underlying concepts in the background
section and, in particular, in the methods section. Others have studied the
concepts of community boundaries, including recent analyses that include time to
travel to neighbors and fields while assessing household spacing (see Berrey et
al. 2021). Second, broader comparisons and connections would bolster the
discussions of this paper, especially since this method can be applied in many
contexts and settings. How do these results and findings compare to other
communities in varying spaciotemporal contexts? Why is defining community
boundaries in the past important? Finally, an additional figure or two would
help contextualize the setting of the study for readers less familiar with the
US SW. I provide more detail on these comments and additional feedback below and
I hope the authors will consider my comments during their revisions. Overall,
this paper will make a positive impact and provides methods that can be used
beyond the US SW for evaluating community boundaries!

The authors situate their study in the context of defining dispersed
communities. This topic is of particular interest to those working in areas of
dispersed farming communities and low-density urbanism. However, the authors may
want to briefly expand on the broader connections between their study and
similar studies in other regions. They may also want to check out the Xtent
model by Ducke and Kroefges (2008), which uses area-based and center size-based
geospatial modeling where smaller communities can be absorbed into larger nearby
communities, similar to the approach taken by the authors. This method goes
beyond the basic application of Thessian polygons to define community
boundaries, which we know is too simplistic.

In terms of defining communities, the authors provide a background in section
3.1 but have no citations; the concept of community and discussions of kin vs
non-kin in communities, how we define community centers based on archaeological
features have been discussed by numerous scholars. A few key citations should be
added to support these ideas. Likewise, these discussions could be expanded on
in the discussion section, highlighting the utility of this study by linking it
to broader contexts and regions.

The authors briefly mention that their Least Cost Path (LCP) models take into
account landscapes and topography in their defining of communities, however,
these seem to be important features, especially for indigenous communities in
the US SW. I am curious to see a deeper discussion of how landscape and
geographic features play into their model, with the knowledge that features like
rivers, mesas, mountains, and more are delineating features for community and
cultural boundaries (and in some contexts, act as agents for social reactors,
bringing people together - for example, springs and wells among modern Maya
communities). Additionally, the authors mention resampling a 30m DEM to a 100m
DEM for their LCP to reduce the time it takes to run the LCP algorithms. While
the authors note that their LCP is not seeking direct routes and rather, general
time it takes to move across the landscape, several studies have noted the
impact of the spatial resolution of the DEM on the resulting LCPs (see Doyle et
al. 2012; Monteleone et al. 2021). Also, for the slope did the authors use
degree slope or percent slope? A quick clarification will allow replicability of
the study.

I wonder if the authors could expand on their results a little more, perhaps
providing a paragraph or two for each of their three study areas along with more
detailed maps that show the dispersal of the communities? I realize that the
authors may be at the limit for words so this may not possible.

The future work section and bullet point list of the conclusion seems to
overshadow the key take-aways of the paper. Adding an additional paragraph that
expands on the last sentence of the paper (lines 507-508) and highlights the
results and broader connections would improve this paper, in my opinion.

A overview figure that shows the locations of the three study areas (CMV, NRG,
and CIB) in the greater US SW / four corners region would be helpful. Likewise,
several key geographic features are mentioned in the text when referring to
Figure 3 (e.g., "just north of Ute Mountain"); these features should be labeled
to help guide the reader who may not be familiar with the US SW.

Another quick round of copy-edits is needed. A few words are misspelled (e.g.,
"Stll" instead of "still" line 477); Figure 4 is mentioned before Figure 2;
refer to Table 2 after the data is presented in paragraph form (lines 367-372);
the citation on line 474 is oddly formatted; the first names of authors are in
the citation on line 129; paragraphs constituting 1 sentence; etc.

Works Cited Berrey, C. Adam, Robert D. Drennan, and Christian E. Peterson.
"Local economies and household spacing in early chiefdom communities." Plos one
16, no. 5 (2021): e0252532. https://doi.org/10.1371/journal.pone.0252532

Doyle, James A., Thomas G. Garrison, and Stephen D. Houston. "Watchful realms:
integrating GIS analysis and political history in the southern Maya lowlands."
Antiquity 86, no. 333 (2012): 792-807.

Ducke, Benjamin, and Peter C. Kroefges. "From points to areas: constructing
territories from archaeological site patterns using an enhanced Xtent model."
(2008): 245-251. https://archiv.ub.uni-heidelberg.de/propylaeumdok/550/

Monteleone, Kelly, Amy E. Thompson, and Keith M. Prufer. "Virtual cultural
landscapes: Geospatial visualizations of past environments." Archaeological
Prospection 28, no. 3 (2021): 379-401.

### Reviewer #3

The authors present an algorithm for discriminating the extent of community
territories. This is a topic of interest to my own research in another area of
North America, so I was happy to have the opportunity to read the manuscript. It
turns out that the algorithm is very specific to the authors' own study area of
the Southwest. This may be somewhat limiting with regard to the interests of
broader readership of JAS. Still, there are portions of the model--both in
conception and mechanics--that could probably be applied to the development of
similar algorithms for other archaeological datasets.

The manuscript is generally well written, even as it covers some fairly
technical details. An exception is in the later discussion where the reader is
presented with some terms and concepts (e.g., Kullback-Leibler Divergence,
MaxEnt) that are not defined and may detract from the readership by all but
specialists in the modeling literature. Likewise, the concluding discussion
takes a pretty deep dive into some issues in Southwest US archaeology. I would
recommend that the authors make some revisions to the recommendations to make
them of broader interest and readability.

However, the algorithm itself--which is the centerpiece of the manuscript--is
clearly explained. My main complain here is not with the writing but with the
seeming arbitrariness of some of the model parameters (D-join of 0.5 hour, using
the rate of the slowest 10% of hikers, proportion of the population (P) at 0.8).
The authors admit some of these arbitrary. As I read I wondered how small tweaks
in one or more of these assumed values might change the outcomes. In the classic
settlement archaeology literature of the late 70s and early 80s, archaeologists
often used low, middle, and high estimates for measures like these. Could they
do something similar here?

A few other finer points of the algorithm struck me as arbitrary but may make
more sense to archaeologists from this region. For example, it seems odd to
define community centers differently for each region. The commute time of one
hour seems low for a relatively arid region, even granting their claim that this
is less than a cross-cultural sample. Perhaps here too the authors could revisit
the discussion with an ear toward broader readership.

All in all, however, the manuscript is interesting and well written. The figures
are clear and the abstract is appropriate. I recommend publication with minor
revisions.
