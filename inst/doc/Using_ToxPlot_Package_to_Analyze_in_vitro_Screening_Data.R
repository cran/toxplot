## ---- message=FALSE, warning=FALSE---------------------------------------
library(dplyr)
devtools::load_all()

knitr::kable(head(demo_mc), caption = "Head rows of demo data")

## ------------------------------------------------------------------------
  #define the names of the primary and toxicity assay.
assay_info <- list(
  prim_assay = "Primary",
  toxi_assay = "Cytotox"
)

## ---- message=FALSE, warning=FALSE---------------------------------------
# normalization
demo_mc_norm <- normalize_per_plate(demo_mc, nctrl = "DMSO")
knitr::kable(head(demo_mc_norm))

## ------------------------------------------------------------------------
# qc
qc <- qc_per_plate(demo_mc_norm, assay_info)
knitr::kable(qc$neg_ctrl_sum)
knitr::kable(qc$pos_ctrl_sum)
knitr::kable(qc$qc)

## ------------------------------------------------------------------------
# curve fitting
mc_norm <- dplyr::filter(demo_mc_norm, wllt == "t")
demo_md <- fit_curve_tcpl(mc_norm, assay_info)


## ------------------------------------------------------------------------
# calculate ranking score
demo_rank <- rank_tcpl(demo_md)
knitr::kable(head(demo_rank))

## ---- message=FALSE, warning=FALSE, fig.show='hold'----------------------
# make plots
demo_plots <- plot_tcpl(demo_md, demo_rank, notation = FALSE)
# Visualize plot
demo_plots[[1]]
demo_plots[[2]]

## ---- message=FALSE, warning=FALSE---------------------------------------

plotly::ggplotly(demo_plots[[2]])

## ---- eval=FALSE---------------------------------------------------------
#  save_plot_pdf(demo_plots, "allplots.pdf")

