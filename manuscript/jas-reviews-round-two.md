## Second round of comments from the editors and reviewers:

### Reviewer #1

I completely understand and acknowledge that the primary goal of this paper is
to highlight a novel adaptation of DBSCAN within the context of a use case
centered on defining communities from the bottom-up. As I said in my original
review, I think that it's an interesting idea and the paper should be published.
Last time there were several very large methodological errors and omissions that
had to be addressed and it does look like the authors have addressed them.
However, the level of dismissiveness in their response to the original peer
review, especially how their comments related to addressing the errors and
omissions came with implied statements that doing so was a waste of their time
because their results did not change, do concern me. It is important to get the
methods right, given that this paper was submitted to JAS and not a journal
focused on postmodern anthropological theory. Just because your clustering
algorithm was run at a coarse-grained enough level of detail to mask the errors
and omissions does not mean that someone else applying your methods in another
context, perhaps at a much finer spatial scale and in a region with more
topographic variability, won't get incorrect results. Since the routing
algorithm was limited to the range of +/-45 degrees of slope, it is not
surprising that varying the spatial resolution of the elevation model and
including the 3D travel distance in the cost function didn't change the results
very much. The region is fairly flat, except for canyon and canyon-like features
that break it up in various spots, so flat stuff will remain flat at every scale
and you'll end up with similar travel times. With that said, the decision to use
the +/-45 range is completely arbitrary, justified with this statement: "The
degree slope of each edge is calculated, and edges with slope estimates greater
than or equal to 45 degrees are removed. This prevents the path analysis from
assuming that a hypothetical hiker would, for instance, scale steep slopes or
walk off a cliff." How did you reach that decision? There are no references to
relevant ethnographic or historical accounts about how Pueblo people, or really
any people, walk in situations like this. None. It's entirely possible that
travelers frequently took shortcuts via walking down into and back up out of the
canyon and canyon-like features. I've walked them in the region and they
generally aren't that bad. You might not be giving your villagers enough credit
for, and flexibility in, how they move. My point is that you need to defend this
decision, especially because of the next thing I have to bring up: you shouldn't
be using Campbell 2019. I was remiss in mentioning this in my last review, and I
will apologize to the authors for that oversight. Campbell published an update
in 2022 (https://doi.org/10.1016/j.compenvurbsys.2022.101866) that is far more
reliable, particularly when you go beyond +/-30 degrees of slope. You can see
the problem in the plot that I generated and attached to this review, which
compares Tobler, Campbell 2019 at the 5th percentile, and Campbell 2022 at the
50th percentile. The 2019 version really breaks down on negative slopes, way
overestimating speed, but you can't see that problem in the published plots
because they cut off at +/-30...perhaps because that was the limit of their data
source. They subsequently gained access to a better source of hiking data and
the 2022 paper has more reliable coefficients for the same Lorentz function.
Given that the paper is now two years old, I'm slightly surprised that the
authors did not know about it, but I would highly encourage them to use the
newer stuff. Even if it doesn't significantly change their results, to my point
above, it still needs to be done right so it can serve as an example to others.

A few other items of note:

-   The responder missed my point about anisotropy. When walking over variable
    terrain, the least costly path from A to B is generally not the same as the
    path from B to A. You acknowledge that in your paper by averaging the
    bidirectional travel times between locations, which is fine. It sounds like
    the library you are using relies upon standard Dijkstra and not the shortcut
    version, which is good to hear.
-   Is the Observed 95% Quantile missing from Figure 4? It's in the legend, but
    not immediately obvious in the plot.
-   I still don't have a good understanding of how you are creating your concave
    polygons. A visual example might really help here. I understand that using
    the paths helps them from turning into really weird croissant shapes, but
    you gloss over *how* the path data is actually used. I can imagine how
    you're doing it, based on what I know about computational geometry, but it's
    better to not assume your readers have that background and be more explicit.
    It's an important component of your analysis.
-   You vacillate between saying that everything is focused on the community
    centers and saying that it's really about traveling between sites within
    communities. If it's both, which I think it is, that needs to be made more
    clear and consistent throughout the paper.
-   The catchment approach that I described is not some novel thing that no one
    has used before. It's well-known and shows up in a variety of archaeological
    contexts, to include some really interesting work done in the Maya region
    (see papers by Adrian Chase). What you describe as an isochrone is generated
    as one of the first steps in the workflow.

### Reviewer #2

This is my second review of the paper titled, "A method for defining dispersed
community territories". My previous review mentioned three key items that I
thought should be addressed: 1) additional citations are needed to support some
of the assumptions and underlying concepts in the background section and, in
particular, in the methods section; 2) broader comparisons and connections would
bolster the discussions of this paper, especially since this method can be
applied in many contexts and settings; and 3) an additional figure or two to
help contextualize the setting of the study for readers less familiar with the
US SW. The authors have integrated these ideas into their revised manuscript as
detailed in their Response to Reviewers letter. The new Figure 1 helps to
situate the reader unfamiliar with the US SW. The methods background and
discussion have been expanded, drawing on broader comparisons and grounding
their framework in previous literature. The revised manuscript narrative is also
less technical and more digestible for the reader. This article makes an
important contribution to our study of community boundaries including
open-access code which will allow method to be employed in regions with robust
settlement data.

## Review of Reproducibility

### Reviewer #4

This is a review only of the reproducibility of the computational code that
accompanies the manuscript. This review was prepared by Ben Marwick, JAS
Reproducibility Specialist. Please feel free to email me with updates and
further discussion about this code review: bmarwick\@uw.edu

Accessing materials: In the manuscript's methods section I found a reference to
this https://github.com/kbvernon/community-centers, however I could not access.
The text also mentioned supplementary materials, where I found a HTML file
'community-clustering.html' which included R code. However, this output format
is not convenient for code execution. I recommend the authors include the source
document with the output HTML file in their supplementary material. I further
recommend they deposit code and data at a trustworthy repository suitable for
long term access and obtain a DOI for the materials to cite in the manuscript.
GitHub is not suitable for research data sharing because files can be changed or
removed at any time by the authors. A service that provides a DOI for the files
is more likely to give long term availability of the research materials. There
are many repositories suitable for this, some examples commonly used by
archaeologists include Archaeology Data Service, Figshare, Open Context, Open
Science Framework, tDAR and Zenodo. Depending on the authors' affiliations, they
may also have free access to a national or institutional repository that is
suitable for archiving your research data. Some of these may be listed on the
Registry of Research Data Repositories (Re3Data), a global registry of research
data repositories across many subject areas.

Organisation of compendium: There is only the single HTML file present. I
recommend adding a README file in markdown or plain text format, that minimally
includes: (1) a citation to the manuscript, and (2) a note that it accompanies a
manuscript; (3) a brief description of the files included in the repository; (4)
the names and version numbers of the key pieces of software used; (5) brief
instructions to the user about how to get started working with the project, eg.
which file to open first.

Code: The code is highly readable and well-annotated. In the authors' custom
function build_region() I can see a reference to a data file:
data/community-centers.gpkg. This file is not included with the supplementary
materials, and there are no instructions on how it can be obtained, so I could
not run the code. There is no data availability statement.

Reproducible Results: The Associate Editor for Reproducibility downloaded all
materials and could not reproduce any of the results presented by the authors.

If the authors make revisions to the code to improve the reproducibility of
their results following my recommendations, I will be happy to re-review the
materials and update the Reproducible Results statement.

If you choose to publish your data article in Data in Brief, an open access fee
of 500 USD will be payable upon acceptance and publication.
