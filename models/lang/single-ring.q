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
A[] ((MvC1.InitialGreen || MvC1.ExtGreen || MvC1.GappedOut) imply L1.Green) &&\
      ((MvC1.RedClear || MvC1.RedNoDemand || MvC1.RedWaiting) imply L1.Red) && \
      (MvC1.RedAmber imply L1.RedAmber) &&\
      (MvC1.Amber imply L1.Amber)

/*

*/
A[] ((MvC0.InitialGreen || MvC0.ExtGreen || MvC0.GappedOut) imply L0.Green) &&\
      ((MvC0.RedClear || MvC0.RedNoDemand || MvC0.RedWaiting) imply L0.Red) && \
      (MvC0.RedAmber imply L0.RedAmber) &&\
      (MvC0.Amber imply L0.Amber)

/*

*/
Det2.Actuated --> L2.Green

/*

*/
Det1.Actuated --> L1.Green

/*

*/
Det0.Actuated --> L0.Green

/*

*/
A[] not deadlock
