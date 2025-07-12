MetaInstructions <- function(HelpType="Plan") {

  switch(HelpType,
         "Overview"={
           output<-c(
             '<b>Inferences?</b> inferences using statistical testing are, of course, subject to errors.',
             '<ul style=margin:0px;>',
             '<li> False hits',
             '<li> False misses',
             '</ul>',
             'How much do these matter?',
             '<br>',
             '<br>',
             '<b>Strategies?</b> a researcher has to make an important choice about sample size because larger sample sizes are more costly. ',
             '<ul style=margin:0px;>',
             '<li> Should I use the biggest I can afford?',
             '<li> Or should I use the smallest I can get away with?',
             '</ul>',
             '<br>',
             '<b>Believable Results?</b> what do we do when there are 2 (or more) different results to compare or contrast?',
             '<ul style=margin:0px;>',
             '<li> Replication asks whether the result can be found again and is therefore competitive.',
             '<li> Meta-analysis asks what inference might cover both results and is therefore collaborative.',
             '</ul>',
             'Which is better?',
             '<br>',
             '<br>',
             '<b>Real Differences</b> sometimes 2 different results can happen quite properly?',
             '<ul style=margin:0px;>',
             '<li> In this case, replication is highly problematical.',
             '<li> Meta-analysis for random effects, however, is good.',
             '</ul>',
             '<br>'
           )
         },
         "Inferences?"={
           output<-c(
             '<b>In the first part of this investigation</b> we use a simple test situation.',
             '<ul style=margin:0px;>',
             '<li> The population effect size is either r<sub>p</sub>=0.0 or r<sub>p</sub>=0.3 with equal probability.',
             '<li> The sample size is 42.',
             '</ul>',
             'Can you guess which population your result came from?',
             'Did you get a statistically significant result?',
             '<br>',
             'Try this a few times and see (i) how easy it is to guess the population and ',
             '(ii) how safe the p-value is as a guide to which population.',
             '<br>',
             '<br>',
             '<b>In the second part of this investigation</b> we use a world that models Psychology.',
             '<ul style=margin:0px;>',
             '<li> The population effect size is either zero (75%) or drawn from an exponential distribution (25%).',
             '<li> The sample size is 42.',
             '</ul>',
             'What happens now? How likely is a significant result? And if you get a significant result, how likely is it false discovery?',
             '<br>'
           )
         },
         
         "Strategies?"={output<-c(
           'Larger sample sizes cost more time, effort and often money. It is therefore worth asking whether two smaller studies are more productive than one large one.',
           'The question is important not least because sample size offers diminishing returns.',
           'The benefit of going from 20 to 40 data points is much, much greater than the benefit of going from 120 to 140.',
           'In this investigation, we look at this.',
           '<br>',
           '<br>',
           '<b>In the first part of this investigation</b> you have a budget of 500 participants and you are operating in the model Psychology world.',
           '<ul style=margin:0px;>',
           '<li> Use all 500 participants in a single study. Note whether you get a significant result and whether it is a false discovery.',
           '<li> Now use 100 participants in each of 5 studies. Note whether how many significant result and how many false discoveries yuo make.',
           '<li> Now use 20 participants in each of 25 studies. Note whether how many significant result and how many false discoveries yuo make.',
           '<li> Now use 4 participants in each of 125 studies. Note whether how many significant result and how many false discoveries yuo make.',
           '</ul>',
           'Which combination gave you the most significant results? This is what will probably matter to you as a researcher.',
           'Which combination gave you the most false discoveries? This is what will matter most to the discipline.',
           '<br>',
           '<br>',
           '<b>For the second part, we are going to do a bit of cheating.</b> Each time we run a study, we start with a pre-planned sample size. If the result is not significant, then we add a few participants.',
           'We continue until either our budget is used up, or we have a significant result.',
           '<br>',
           'How does this affect the outcomes? Can you see any temptation here?',
           '<br>')
         },
         
         "Believable Results?"={output<-c(
           'False discoveries are inevitable. For the most part their frequency is driven by the number of false hypotheses.',
           'It is hard to know whether a hypothesis is true or false and so there are no really good ways of preventing false discoveries.',
           'Instead, we must check up on a promising looking result.',
           '<br><br>',
           'There are two ways to do this:',           
           '<ul style=margin:0px;>',
           '<li> Replication: repeat the result and prefer the new result',
           '<li> Meta-analysis: repeat the result and combine the new result with the old one',
           '</ul>',
           'How do the two compare?',
           '<br><br>',
           '<b>In the first part of this investigation</b>, we look at replication.',
           'There are 3 types of outcome: ns no follow-up; sig, then ns; sig then sig.',
           'If the population effect size is zero, then the first two outcomes are correct.',
           'If the population effect size is not zero, then the third outcome is correct.',
           'How many correct results does replication produce?',
           '<br>',
           'Replication is widely used and accepted, but is that entirely safe?',
           '<br><br>',
           '<b>In the second part of this investigation</b>, we look at meta-analysis.',
           'Although normally used with many studies, the process can be applied to just two studies',
           'and we can think of it as a way of combining an original study and the replication.',
           'As before, there are three possible outcomes and as before, we ask how many correct results meta-analysis produces.',
           '<br><br>',
           'What we see is the familiar issue of a trade-off between false discoveries (very few for replication)',
           'and false misses (very many for replication).',
           'Actually, the same trade-off exists for just one study when one changes alpha (normally 0.05).',
           '<br>')
         },
         
         "Real Differences"={output<-c(
           'When a study fails to replicate, this is usually understood to be an indication that the original finding was a false discovery.',
           'And, <it>sometimes</it> it is thought that the original study was in some way faulty.',
           '<br><br>',
           'In this investigation, we set up a situation where two different researchers get completely conflicting results.',
           'However, there is a good reason for this. ',
           '<br><br>',
           'In short, the two researchers are, without noticing it, studying different populations as might happen if they worked in different countries.',
           'This can be shown by including a third variable in the hypothesis, where the different countries favour different values for that variable.',
           '<br><br>',
           'It is hoped that these investigations have given you some insight into how statistical analysis works when it is scaled up across a whole discipline.',
           '<br>'
           )
         }
         )
  
  if (HelpType!="Overview")
  extras<-paste0('<br>',
                 'More information ',
                 '<a href=',
                 '"https://doingpsychstats.wordpress.com/investigation-',HelpType,'/"',
                 ' target="_blank">',
                 'here',
                 '</a>',
                 ' and leave any comments ',
                 '<a href=',
                 '"https://doingpsychstats.wordpress.com/investigation-',HelpType,'/#respond"',
                 ' target="_blank">',
                 'here',
                 '</a>'
  )
  else extras<-c()
  
  output<-c(output,extras)
  output<-c("<div style='border: none; padding: 4px;'>",output,"</div>")
  
  wholePanel<-paste0(output,collapse=" ")
  return(wholePanel)
}
