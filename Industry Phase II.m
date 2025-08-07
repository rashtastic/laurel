# 20250807 - Phase II

Okay so I recreated the project folder and made it read-only to protect my precious code. Here's the data I looked at and some initial thoughts I have

## FEAS

`FEAS Data.xlsx`

FEAS records are not rich in terms of content, they don't have text descriptions like the Faculty Briefs do. But if there's a relevant FEAS work type for some activity of interest, I'd say there's fair arguments to use it as the basis for a metric. Also FEAS is something we'll want to get more familiar with as we're going to rely on it for arts and things like that.

What I would suggest is that you look through each sheet, don't even scroll down, just fly through each one and see if any jump out as *extremely* relevant to industry stuff you're looking for. The sheets are named after internal FEAS work types; I chose the 50 out of about 200 that seemed maybe relevant.

One I saw was that `Professional Service` has organizations and the role a person held in it. Role and organization are fortunately required fields for that table. But roles aren't standardized, it looks like someone can enter whatever they want. Here's the most common ones:

| Role                     |     n |
| :----------------------- | ----: |
| Member                   | 2,816 |
| Reviewer                 |   618 |
| Chair                    |   614 |
| President                |   337 |
| Committee Member         |   312 |
| Program Committee Member |   268 |
| Session Chair            |   203 |
| Board Member             |   184 |
| Discussant               |   148 |
| Secretary                |   133 |
| Co-Chair                 |   126 |
| Proposal Reviewer        |   113 |
| Organizer                |   107 |
| Treasurer                |    96 |
| Referee                  |    85 |
| Panelist                 |    84 |
| Program Committee        |    82 |
| Board of Directors       |    82 |
| Vice President           |    77 |
| member                   |    75 |

With this or any other sheet that's relevant, what we'd probably want to do is
1. Filter it to current faculty, maybe our EDS population
2. Choose a date window for what content is relevant

and if there's enough data left in a sheet that seems useful,

3. Determine if we want to do an AI pass to categorize things, like we could try labelling organizations as "clearly academic" vs. "clearly professional"


## Faculty Briefs and FSU News

Data is in `FSU News and Faculty Briefs.xlsx`

Okay unless there is a very relevant FEAS work type, this is probably the most promising source of industry/innovation kinds of things. The column `Industry Impact Status` is True/False based on if the AI decided it was relevant to industry activity. There's also a high/medium/low confidence score which it rates the confidence of its selection. The tables are sorted from high confidence in relevance to high confidence in not relevant. I think I limited it to 2023+.

What you should do here is "Phase II" of the AI pass:
1. Look through a couple dozen of the high-confidence True rows. Do they all seem to be correct? Do you immediately see wrong ones? We're looking for mistakes
2. Same thing for high-confidence False rows. These will probably be more varied in content. So  skim some of these and see if you quickly find any that should have counted.
3. I barely looked at the medium-confidence ones. I'm not sure how many there are. We want to know if there's a lot there that should count and if there's a lot that should be easily dismissed.

The goal isn't to hand-check if the classifications are right or not (across both sheets there's ~3,500 rows), but to find *patterns* in false positives, false negatives, and things it finds ambiguous. If you look at say 5% of the high-confidence ones and don't find a single misclassification, we can be pretty confident it's doing a great job. If there is an identifiable tendency towards misclassification, we would sharpen the instruction prompt and run the data again. We keep doing this until we're happy with the results, or so unhappy that we give up.

## [SciVal](https://www.scival.com/landing)

If you haven't looked at SciVal, we have campus-wide access to SciVal data through a libraries subscription. You "log in via institution" and go to "Explore."

- Their data is always lagged, so for every metric, schools shows sharp declines 2023->2024->2025, it isn't just us.
- Some of the data I'll describe looks weird/wrong. If it's worth digging deeper, we'd ask Jeremy Katz for help/info

I exported some of the data into `SciVal.xlsx`

I took this as an opportunity to take a close look at what's in SciVal, which I had been putting off. So this is kind of a survey of the things I looked at in there, not necessarily industry-related only.

### [Media Mentions](https://www.scival.com/overview/mediaImpact?uri=Institution/508065)

>Media analyses are provided by Newsflo, which is focused on English language content only.  
>
>Media mentions data is no longer updated in SciVal as of January 2024 and will be removed in the near future. We are working to replace it with media citations data instead.

Okay, so this was the main thing I had in mind when I thought of SciVal. And they do have media mentions, but not in a way that seems useful for this exercise. It has print and online mentions up through 2023 with the media source and title. The online ones have no URLs.

So just checking one,

[When sea levels rise, so does your rent](https://www.bbc.com/news/world-67418276) 

>Prof William Butler of Florida State University, says the higher ground was once affordable because it was "the least desirable place to be".

Okay, not bad

Then we have things that aren't about FSU in the way we are looking for like unrelated stories about alums or notorious events
- [Life Sciences IP Attorney Joins Patent Team at Panitch Schwarze](https://www.panitchlaw.com/life-sciences-ip-attorney-joins-patent-team-at-panitch-schwarze/)
- Catching up with Jupiter Reality TV star Tyler Cameron: 'Special Forces', dating and his gala
- Dan Markel murder: Ex mother-in-law of murdered FSU professor arrested on way to Vietnam just days after son's conviction

So it's a mixed bag. But there's 100K+ mentions going back to 2011 which, even with the large number of duplicate articles published in multiple outlets, is an impressive amount of data. And there's maybe some interesting analyses on how FSU has existed in media over time. What I'm thinking with this is it's probably not helpful for an industry metric, but could be a very broad source of content when looking for specific things. Like these headlines are pretty unambiguous in what they're about

- FSU researcher earns $2.7 million grant to study diet, metabolism and brain connections
- Space Weather From Our Local Star Disrupts Nocturnal Bird Migration On Earth
- $2.7M Grant Awarded for Diet, Metabolism, Brain Study
- US Patent Issued to FLORIDA STATE UNIVERSITY RESEARCH FOUNDATION on Oct. 10 for Materials and methods for expansion of stem cells
- Museum of the Moving Image and Alfred P. Sloan Foundation Announce Student Prize Finalists

Of course we don't have the media content to parse, but if we wanted to know "what has FSU ever done related to the Sloan Foundation", this + FSU News/Briefs could be very comprehensive for just finding references to things that happened. Well, if SciVal starts collecting media information again.

### Collaborations

The immediate thing I'll jump to is they have a [corporate collaborations](https://www.scival.com/collaboration/collabMetrics/sectorView?uri=Institution/508065) section. They have corporate, gov't, medical, academic, and "other", where "collaboration" means co-authoring a paper with someone from one of those.

Our top corporate collaborator is allegedly Royal Dutch Shell PLC? And looking at the publications, they have to be wrong, they're about medicine and even the one about fuels doesn't indicate any relationship with Shell. Nonetheless, SciVal reports this as a metric specifically called "Academic-corporate collaboration" so maybe it's something to consider.

The data includes DOI and Scopus ID's so there's potentially things we could do like attach to EMPLIDs, filter by current faculty status, etc.

### Patents/Policies

In other sections they have

>Patents citing the Scholarly Output published at Florida State University

>Scholarly Outputs at Florida State University that have been cited in patents

>Policy Documents citing Scholarly Output published at Florida State University

>Scholarly Output cited by Policy

I hadn't thought about patents with respect to bibliometrics, but it does make sense. it's all public data and tech to extract bibliographic citations from text/documents is pretty good now. So this is pretty neat. 11k patents listed since 1997. For US patents it has a link to some page with all the info, but not USPTO. Also the SciVal patents table *doesn't* include the DOI of what it's citing, which is unfortunate. Okay let me try and find one I should know something about

>Method and system for predicting relevant network relationships, SAS Institute

Okay I can see what it cited and it is someone from FSU. So this data is making sense.

Then they have another table of FSU publications *cited* by a patent, which has the publication and author info but *not* the patent info? Why would they do this?

Same situation with policy. That we can't link the policy to the FSU publication (at least not readily) limits what we could do in terms of metrics; maybe the citation was something published at FSU 20 years ago. But this might be interesting for finding ways to highlight/emphasize non-STEM impact, like we could categorize the policies into categories like "Public Health", "Gerontology", whatever. Maybe it would be useful to go in the other direction, the list of FSU publications (with DOI, authors, etc.) which were cited in policy. But I don't see why they would do the hard work of figuring out the citations network and then leave out the most useful information of what policy/patent actually cites what paper. I might ask Jeremy to ask them about that.
