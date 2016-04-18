# # this script contain definition of graphing functions for logistic regression
# ds <- d
# x_name = "age_in_years"
# y_name = "smoke_now"
# color_group = "female"
# alpha_level = .5

# ---- simple-curve-plot -------------------------------

binomial_smooth <- function(...) {
  geom_smooth(method = "glm", method.args = list(family = "binomial"), ...)
}

graph_logitstic_curve_simple <- function(
  ds, 
  x_name, 
  y_name, 
  color_group, 
  alpha_level=.5
){
  # To fit a logistic regression, you need to coerce the values to
  # a numeric vector lying between 0 and 1.
  d[,y_name] <- as.numeric(d[,y_name])
  
  ggplot(d, aes_string(x_name,y_name,color=color_group )) +
    geom_jitter(height = 0.2, shape=21, fill=NA) +
    binomial_smooth() +
    facet_grid(. ~ study_name) +
    main_theme +
    theme(
      legend.position="right"
    )
}
# graph_logitstic_curve_simple(x_name = "age_in_years",
#                              y_name = "smoke_now",
#                              color_group = "female",
#                              alpha_level = .5)

# ---- complex-curve-plot-4 -----------------------
# covar_order <- c("female","marital","educ3","poor_health")

graph_logitstic_curve_complex_4 <- function(
  ds, 
  x_name, 
  y_name, 
  covar_order,
  alpha_level
){
  g_1 <- graph_logitstic_curve_simple(ds,x_name, y_name, covar_order[1], alpha_level)
  g_2 <- graph_logitstic_curve_simple(ds,x_name, y_name, covar_order[2], alpha_level)
  g_3 <- graph_logitstic_curve_simple(ds,x_name, y_name, covar_order[3], alpha_level)
  g_4 <- graph_logitstic_curve_simple(ds,x_name, y_name, covar_order[4], alpha_level)
  
  grid::grid.newpage()    
  #Defnie the relative proportions among the panels in the mosaic.
  layout <- grid::grid.layout(nrow=4, ncol=1,
                              widths=grid::unit(c(1), c("null")),
                              heights=grid::unit(c(.2, .2, .2,.2,.2) ,c("null","null","null","null","null"))
  )
  grid::pushViewport(grid::viewport(layout=layout))
  print(g_1,  vp=grid::viewport(layout.pos.row=1, layout.pos.col=1 ))
  print(g_2, vp=grid::viewport(layout.pos.row=2, layout.pos.col=1 ))
  print(g_3,    vp=grid::viewport(layout.pos.row=3, layout.pos.col=1 ))
  print(g_4,    vp=grid::viewport(layout.pos.row=4, layout.pos.col=1 ))
  grid::popViewport(0)
  
} 
# graph_logitstic_curve_complex_4(
#   ds = d,
#   x_name = "age_in_years",
#   y_name = "smoke_now",
#   covar_order = c("female","marital","educ3","poor_health"),
#   alpha_level = .3)
# 






# ---- simple-point-plot ------------------------------------
graph_logistic_point_simple <- function(
  ds, 
  x_name, 
  y_name, 
  color_group, 
  alpha_level=.5
  ){
  g <- ggplot2::ggplot(ds, aes_string(x=x_name)) +
    geom_point(aes_string(y=y_name, color=color_group), shape=16, alpha=alpha_level) +
    facet_grid(. ~ study_name) + 
    main_theme +
    theme(
      legend.position="right"
    )
  # return(g)
}

# ---- complex-point-plot-4 -----------------------
# covar_oder <- c("female","marital","edu3","poor_health")
graph_logistic_point_complex_4 <- function(
  ds, 
  x_name, 
  y_name, 
  covar_order,
  alpha_level
){

  g_1<- graph_logistic_point_simple(ds,x_name, y_name, covar_order[1], alpha_level)
  g_2 <- graph_logistic_point_simple(ds,x_name, y_name, covar_order[2], alpha_level)
  g_3 <- graph_logistic_point_simple(ds,x_name, y_name, covar_order[3], alpha_level)
  g_4 <- graph_logistic_point_simple(ds,x_name, y_name, covar_order[4], alpha_level)
  
  grid::grid.newpage()    
  #Defnie the relative proportions among the panels in the mosaic.
  layout <- grid::grid.layout(nrow=4, ncol=1,
                              widths=grid::unit(c(1), c("null")),
                              heights=grid::unit(c(.2, .2, .2,.2,.2) ,c("null","null","null","null","null"))
  )
  grid::pushViewport(grid::viewport(layout=layout))
  print(g_1,  vp=grid::viewport(layout.pos.row=1, layout.pos.col=1 ))
  print(g_2, vp=grid::viewport(layout.pos.row=2, layout.pos.col=1 ))
  print(g_3,    vp=grid::viewport(layout.pos.row=3, layout.pos.col=1 ))
  print(g_4,    vp=grid::viewport(layout.pos.row=4, layout.pos.col=1 ))
  grid::popViewport(0)
  
} 
# graph_logistic_point_complex_4(
#   ds = d,
#   x_name = "age_in_years",
#   y_name = "smoke_now_p",
#   covar_order = c("female","marital","educ3","poor_health"),
#   alpha_level = .3)
# 
























###### OLD GRAPH BELOW = STUDY AS ROWS ################
graph_logistic_simple_vfacet <- function(ds, x_name, y_name, color_group, alpha_level=.5){
  g <- ggplot2::ggplot(ds, aes_string(x=x_name)) +
    geom_point(aes_string(y=y_name, color=color_group), shape=16, alpha=alpha_level) +
    facet_grid(study_name ~ .) + 
    main_theme +
    theme(
      legend.position="top"
    )
  # return(g)
}
# g <- graph_logistic_simple(ds=ds,"age_in_years", "smoke_now_p", "sex", .3)
# g





# ---- define-complex-3-graph-function-study-row -----------------------

graph_logistic_complex_3 <- function(
  ds, 
  x_name, 
  y_name, 
  alpha_level
){
  g_female <- graph_logistic_simple(ds,x_name, y_name, "female", alpha_level)
  g_marital <- graph_logistic_simple(ds,x_name, y_name, "marital", alpha_level)
  g_educ <- graph_logistic_simple(ds,x_name, y_name, "educ3", alpha_level)
  
  grid::grid.newpage()    
  #Defnie the relative proportions among the panels in the mosaic.
  layout <- grid::grid.layout(nrow=1, ncol=3,
                              widths=grid::unit(c(.333, .333, .333) ,c("null","null","null")),
                              heights=grid::unit(c(1), c("null"))
  )
  grid::pushViewport(grid::viewport(layout=layout))
  print(g_female,     vp=grid::viewport(layout.pos.row=1, layout.pos.col=1 ))
  print(g_marital, vp=grid::viewport(layout.pos.row=1, layout.pos.col=2 ))
  print(g_educ,    vp=grid::viewport(layout.pos.row=1, layout.pos.col=3 ))
  grid::popViewport(0)
  
} 
# graph_logistic_complex_3(ds=d,"age_in_years", "smoke_now_p", .3)


# ---- define-complex-8-graph-function-study-row -----------------------
graph_logistic_complex_8 <- function(
  ds, 
  x_name, 
  y_name, 
  alpha_level
){
  g_sex <- graph_logistic_simple(ds,x_name, y_name, "sex", alpha_level)
  g_marital <- graph_logistic_simple(ds,x_name, y_name, "marital", alpha_level)
  g_educ <- graph_logistic_simple(ds,x_name, y_name, "educ3", alpha_level)
  
  grid::grid.newpage()    
  #Defnie the relative proportions among the panels in the mosaic.
  layout <- grid::grid.layout(nrow=1, ncol=8,
                              widths=grid::unit(c(.125, .125, .125, .125,
                                                  .125, .125, .125, .125) ,
                                                c("null","null","null","null",
                                                  "null","null","null","null")),
                              heights=grid::unit(c(1), c("null"))
  )
  grid::pushViewport(grid::viewport(layout=layout))
  print(g_sex,     vp=grid::viewport(layout.pos.row=1, layout.pos.col=1 ))
  print(g_marital, vp=grid::viewport(layout.pos.row=1, layout.pos.col=2 ))
  print(g_educ,    vp=grid::viewport(layout.pos.row=1, layout.pos.col=3 ))
  grid::popViewport(0)
  
} 
# graph_logistic_complex_8(ds=d,"age_in_years", "smoke_now_p", .3)
