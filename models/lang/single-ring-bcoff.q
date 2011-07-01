//This file was generated from (Academic) UPPAAL 4.1.3 (rev. 4577), September 2010

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
A<> (MvC1.RedNoDemand)

/*

*/
A[] ((MvC11.InitialGreen || MvC11.ExtGreen || MvC11.GappedOut) imply L11.Green) &&\
      ((MvC11.RedClear || MvC11.RedNoDemand || MvC11.RedWaiting) imply L11.Red) && \
      (MvC11.RedAmber imply L11.RedAmber) &&\
      (MvC11.Amber imply L11.Amber)

/*

*/
A[] ((MvC0.InitialGreen || MvC0.ExtGreen || MvC0.GappedOut) imply L0.Green) &&\
      ((MvC0.RedClear || MvC0.RedNoDemand || MvC0.RedWaiting) imply L0.Red) && \
      (MvC0.RedAmber imply L0.RedAmber) &&\
      (MvC0.Amber imply L0.Amber)

/*

*/
Det12.Actuated --> L12.Green

/*
late:false\/false
16\/16 --> 96s
20\/20 --> 178s
24\/24 --> 597s
*/
Det11.Actuated --> L11.Green

/*
late:false\/false
16\/16 --> 267s
*/
Det0.Actuated --> L0.Green

/*
late: false\/false
24\/24: 17s
*/
A[] not deadlock
