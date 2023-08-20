encode partner, gen(partner1)
xtset partner1 year
gen ratio= m_jt/m_t
gen lnratio = log(ratio)
gen lnm_jt= log(m_jt)
gen lnGDP = log(gdp) 
gen lnvol_BRI = log(vol_bri) 
ssc install reghdfe
reghdfe lnm_jt lnGDP bri_jbri_t, absorb(partner year)
reghdfe lnm_jt lnGDP bri_jgdp_j, absorb(partner year)
reghdfe lnm_jt lnGDP tot_jgdp, absorb(partner year)
reghdfe lnm_jt lnGDP  bri_jgdp_j tot_jgdp, absorb(partner year)
generate preBRI = year < 2013
generate postBRI = year > 2012
graph bar m_jt, over(postBRI) ytitle(Mean Exports to China)
graph bar m_jt, over(BRI) ytitle(Mean Exports to China)
graph bar BRI postBRI, over(m_jt) *do not have sufficient version of stata:(*
scatter lnvol_BRI lnm_jt
scatter lnm_jt lnGDP
*pre and post* & *low and large BRI investment* --> average amount of export 
graph bar postBRI nobri, over(m_jt) ytitle(Mean Exports to China)
_pctile gdp, p(80)
_pctile gdp. p(20)
generate low = gdp < 2
generate high = gdp > 41
graph bar M_jt low, over(postBRI) ytitle(Mean Exports to China)
