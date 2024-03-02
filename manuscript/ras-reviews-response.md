Reviewers provided important and insightful comments that helped us improve this
paper considerably. Perhaps the biggest revision is that we now include some
limited sensitivity analysis to evaluate what happens when parameter values are
changed. As two of the reviewers raised concerns about the resolution of the
grid, tests were also conducted to see if higher resolutions would have a
noticeable impact on the results - they did not. Finally, two of the reviewers
asked that we add some broader implications to the discussion. This was done by
highlighting differences between the types of communities we are trying to
understand and other types of communities (religious, linguistic, etc.) that
archaeologists might find relevant to their research.

Note: minor formatting and spelling errors identified by the reviewers were
corrected in the text but are not discussed here.

### Response to Reviewer 1

1.  Distance traveled should be measured with hypotenuse.

    Response: The reviewer is correct about this, so the analysis was updated to
    account for it. It required only minor changes to the R code. We also note
    that the effect was minimal as a maximum slope was defined to constrain
    travel paths, so the difference in travel time ended up being less than a
    minute in most cases.

2.  Use 5th percentile in Lorentz curve as recommended by Campbell.

    Response: This was a major oversight on our part that we have now corrected,
    and we thank the reviewer for bringing it to our attention. As requested, we
    also clarify that we are using the 5th percentile of the Lorentz curve in
    text.

3.  Aggregation of elevation model grid cells biases estimates.

    Response: The concern is valid, so we conduct an additional sensitivity
    analysis at four different levels of aggregation (from no aggregation to the
    level of aggregation used in the paper). Descriptions of this were added to
    the methods and results. To summarize, we found that increasing resolution
    beyond that used in our paper did not have a meaningful impact on the
    results.

4.  Bi-directional Dijkstra forces isotropy.

    Response: In bi-directional search on a directed graph, search from the
    destination node uses edge weights in the direction of the destination node,
    not edge weights in the direction of the origin node as the reviewer seems
    to be implying, so anisotropy is preserved. At any rate, it appears to be a
    moot point since `{cppRouting}` uses regular old Dijkstra's algorithm when
    `get_distance_matrix()` is applied to an uncontracted graph (the method used
    here). So, what the reviewer wants is what we actually did. We just
    described it wrong. This has been corrected in the text.

5.  Reviewer proposes alternative clustering strategy.

    Response: The proposed alternative strategy for defining communities is an
    intriguing one, but not fundamentally different than what we propose. There
    are three main differences.

    \(i\) Rather than searching the entire grid, search in our algorithm ends
    when all sites are reached, which reduces the time complexity.

    \(ii\) The proposed alternative doesn't specify a rule for joining
    communities, which we consider to be one of the two key contributions of our
    algorithm (the other is weighting distance by population size).

    \(iii\) If i understand it correctly, the proposed alternative for defining
    boundaries is to use the smallest isochrone around all the centers in a
    community that encompasses all the nearby farm sites. This is an intriguing
    suggestion that deserves further consideration, and we would love to see a
    follow-up paper that explores it more. We note, however, that it would not
    guarantee concavity in the community polygon with respect to time - meaning
    the shortest path between two sites in the community would not be guaranteed
    to remain in the community. Of course, it could be argued that that's a
    difference that doesn't actually make a difference, that these are just
    crude estimates anyway. Our argument would be that interactions did not
    occur only at community centers, so the shortest path between all sites is
    probably relevant to defining the spatial extent of these farming
    communities. If the people living on these farms were routinely visiting
    their neighbors, the routes they took would have formed an important element
    of their spatial or geographic community.

### Response to Reviewer 2

1.  Include additional citations in methods.

    Response: Done! See especially the section on defining community centers.

2.  Discuss broader connections outside the regional focus.

    Response: We add two paragraphs to the discussion elaborating on the type of
    community we are delineating and how that differs from other types of
    communities that may be of interest to archaeologists and anthropologists,
    focusing in particular on different dimensions of community organization -
    biological relatedness, shared metaphors, religion, language, etc.

3.  Add map with place names mentioned in text.

    Response: Done! This actually provides a lot of context that will hopefully
    help readers better interpret the results. In fact, any reference to
    specific locations in the text were updated to ensure that they used the
    labeled locations in the map. It was also an enjoyable exercise! Thanks for
    the request!

4.  Include some discussion of how visual landmarks might shape these
    communities.

    Response: This is an intriguing idea. Bernardini and Peeples (2017, "Sight
    communities," *Am Ant V*80 N2) provide a good example of this as they use
    visual landmarks and viewsheds to define "sight communities." That said, our
    goal here is to define the spatial extent of dispersed *farming*
    communities, not sight communities, so we focus on farmsteads that serve as
    indicators of the locations of farms and bind them together into communities
    using the centers at which farmers would have interacted on a fairly regular
    basis.

5.  Aggregation of elevation model grid cells biases estimates.

    Response: See response to reviewer 1.

6.  Clarify whether slope is degree slope or percent slope.

    Response: Campbell's hiking function is specified to work with degree slope
    by default. This was clarified in the text.

### Response to Reviewer 3

1.  Discuss broader connections outside the regional focus.

    Response: See response to Reviewer 2.

2.  Sensitivity analysis to evaluate model parameters.

    Response: Done! In general, we found that the algorithm behaved as expected,
    though we note some volatility in the Cibola data. This is probably owing to
    the geographic sparsity of that sample, particularly with respect to the
    ratio of farms to centers.

3.  Region-specific definitions of community centers.

    Response: To clarify our reasons for this, we added the following to the
    section on community centers:

    "For given differences in population density and settlement patterning, the
    frequency and intensity of interaction between individuals at centers is
    likely to vary by region, so it is reasonable to expect that community
    centers themselves (at least in so far as they play the role of centers)
    should vary in their size and composition across regions, too."
