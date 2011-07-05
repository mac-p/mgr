//This file was generated from (Academic) UPPAAL 4.1.3 (rev. 4577), September 2010

/*
No deadlock.
*/
A[] not deadlock

/*
Light00 conforms to Ctrl00 (green)
*/
A[] ((MvC00.InitialGreen || MvC00.ExtGreen || MvC00.GappedOut || MvC00.Rest) imply L00.Green)

/*
Light00 conforms to Ctrl00 (red)
*/
A[] ((MvC00.RedClear || MvC00.RedNoDemand || MvC00.RedWaiting) imply L00.Red)

/*
Light00 conforms to Ctrl00 (red+amber)
*/
A[] (MvC00.RedAmber imply L00.RedAmber)

/*
Light00 conforms to Ctrl00 (amber)
*/
A[] (MvC00.Amber imply L00.Amber)

/*
Liveness for 00 (fol. actuation)
*/
Det00.Actuated --> L00.Green

/*
Liveness for 00 (fol. no service)
*/
!service[0] --> L00.Green
