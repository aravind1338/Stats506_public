library(tidyverse)

demo_data = read_delim('/Users/aravind/Desktop/Stats506_public/week6/nhanes_demo.csv', delim = ',')
ohxden_data = read_delim('/Users/aravind/Desktop/Stats506_public/week6/nhanes_ohxden.csv', delim = ',')


merged_demo = merge(ohxden_data, demo_data, by='SEQN') %>%
  select(-contains('OHX')) %>%
  mutate(id = SEQN, gender = RIAGENDR, age = RIDAGEYR,
         under_20 = age < 20, college = ifelse(DMDEDUC2 < 7,
                                                'some college/college graduate',
                                               'No college/<20'), 
         exam_status = RIDSTATR, ohx_status = OHDDESTS,
         ohx = ifelse(exam_status==2 & ohx_status==1, "complete", "missing")) %>%
  filter(exam_status == 2)


new_table = merged_demo %>%
  summarize(under_20 = n()) %>%
  select(under_20)
