//This file was generated from (Academic) UPPAAL 4.1.3 (rev. 4577), September 2010

/*

*/
A[] (MvC0.RedWaiting imply MvC0.wait_t < 30)

/*

*/
sup{MvC0.RedWaiting}: MvC0.wait_t

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
Overapproximation works!
*/
A[] ((MvC11.InitialGreen || MvC11.ExtGreen || MvC11.GappedOut) imply L11.Green) &&\
      ((MvC11.RedClear || MvC11.RedNoDemand || MvC11.RedWaiting) imply L11.Red) && \
      (MvC11.RedAmber imply L11.RedAmber) &&\
      (MvC11.Amber imply L11.Amber)

/*
Depth first
HOLD: true
LATE: false
MAX: 16
66,5s

Overapproximation works!
*/
A[] ((MvC0.InitialGreen || MvC0.ExtGreen || MvC0.GappedOut) imply L0.Green) &&\
      ((MvC0.RedClear || MvC0.RedNoDemand || MvC0.RedWaiting) imply L0.Red) && \
      (MvC0.RedAmber imply L0.RedAmber) &&\
      (MvC0.Amber imply L0.Amber)

/*
Depth first
HOLD: true
LATE: false
MAX: 16
3035s
*/
Det12.Actuated --> L12.Green

/*
Depth first
HOLD: true
LATE: false
MAX: 16
3026s
*/
Det11.Actuated --> L11.Green

/*
Depth first
HOLD: true
LATE: false
MAX: 16
66,5s
3412s
*/
!service[0] --> L0.Green

/*
Depth first
HOLD: true
LATE: false
MAX: 16
3029s
*/
Det0.Actuated --> L0.Green

/*
HOLD: true
LATE: false
MAX: 16
*/
(Det0.Actuated && (MvC0.RedNoDemand || MvC0.RedClear || MvC0.Amber)) --> (L0.Green && MvC0.wait_t < 80)

/*
HOLD: true
LATE: false
-------------------
MAX: 16 -->463s
MAX: 12 -->397s
*/
A[] not deadlock
