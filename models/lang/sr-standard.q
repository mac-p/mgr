//This file was generated from (Academic) UPPAAL 4.1.3 (rev. 4577), September 2010

/*

*/
A[] (MvC0.RedWaiting imply MvC0.wait_t < 50)

/*

*/
sup: demand[0]

/*

*/
sup: PC1.mvmts_not_out

/*

*/
sup: PC1.mvmts_on

/*

*/
sup: demand[1]

/*

*/
A[] (rest imply (!demand[0] && !demand[1]))

/*

*/
A[] (rest imply !PC1.timer_set)

/*

*/
A<> (MvC11.RedNoDemand)

/*

*/
A[] ((MvC11.InitialGreen || MvC11.ExtGreen || MvC11.GappedOut || MvC11.Rest) imply L11.Green) &&\
      ((MvC11.RedClear || MvC11.RedNoDemand || MvC11.RedWaiting) imply L11.Red) && \
      (MvC11.RedAmber imply L11.RedAmber) &&\
      (MvC11.Amber imply L11.Amber)

/*
48\/48 -> 65s
*/
A[] ((MvC0.InitialGreen || MvC0.ExtGreen || MvC0.GappedOut || MvC0.Rest) imply L0.Green) &&\
      ((MvC0.RedClear || MvC0.RedNoDemand || MvC0.RedWaiting) imply L0.Red) && \
      (MvC0.RedAmber imply L0.RedAmber) &&\
      (MvC0.Amber imply L0.Amber)

/*

*/
Det12.Actuated --> L12.Green

/*

*/
(Det11.Actuated && (MvC11.RedNoDemand || MvC11.RedClear || MvC11.Amber)) --> (L11.Green && MvC11.wait_t < 60)

/*

*/
A[] (L0.Amber imply L0.green_t >= 7)

/*

*/
inf{L0.Amber}: L0.green_t

/*

*/
!service[1] --> L11.Green

/*
late:false\/false
16\/16 --> 40s
20\/20 --> 99s
24\/24 --> 569s
*/
Det11.Actuated --> L11.Green

/*

*/
!service[M00] --> L00.Green

/*
24\/24 --> 27,4
32\/32 --> 31,5s
48\/48 --> 118s
*/
Det0.Actuated --> L0.Green

/*

*/
(Det00.Actuated && (MvC00.RedNoDemand || MvC00.RedClear || MvC00.Amber)) --> (L00.Green && MvC00.wait_t < 46)

/*
late: false\/false
24\/24 --> 4,13s
48\/48 --> 9s

*/
A[] not deadlock
