//This file was generated from (Academic) UPPAAL 4.1.3 (rev. 4577), September 2010

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
Phase inactive -> Mvmt inactive
*/
A[] (PC0.Inactive imply (MvC00.RedNoDemand || MvC00.RedGotCall || MvC00.RedWaiting))

/*

*/
A[] (PC0.InactiveWaiting imply (MvC00.RedNoDemand || MvC00.RedGotCall || MvC00.RedWaiting))

/*
One phase active at time
*/
A[] (PC0.Active + PC1.Active <= 1)

/*
No deadlock.
*/
A[] not deadlock

/*
Liveness for 00 (fol. actuation)
*/
Det00.Actuated --> L00.Green

/*
Liveness for 00 (fol. no service)
*/
!service[M00] --> L00.Green
