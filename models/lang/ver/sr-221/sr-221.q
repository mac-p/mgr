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
!service[M00] --> L00.Green

/*
Initial green length
*/
A[] (L00.Amber imply L00.green_t >= INIT_GREEN)

/*
Safety at phase level 0
*/
A[] ((RC.Active && RC.cur == 0) imply (PC1.Inactive || PC1.InactiveGotCall || PC1. InactiveWaiting))

/*
Safety at phase level 0
*/
A[] ((RC.Active && RC.cur == 0) imply (PC2.Inactive || PC2.InactiveGotCall || PC2. InactiveWaiting))

/*
Safety at phase level 1
*/
A[] ((RC.Active && RC.cur == 1) imply (PC0.Inactive || PC0.InactiveGotCall || PC0. InactiveWaiting))

/*
Safety at phase level 1
*/
A[] ((RC.Active && RC.cur == 1) imply (PC2.Inactive || PC2.InactiveGotCall || PC2. InactiveWaiting))

/*
Safety at phase level 2
*/
A[] ((RC.Active && RC.cur == 2) imply (PC0.Inactive || PC0.InactiveGotCall || PC0. InactiveWaiting))

/*
Safety at phase level 2
*/
A[] ((RC.Active && RC.cur == 2) imply (PC1.Inactive || PC1.InactiveGotCall || PC1. InactiveWaiting))

/*
Light11 conforms to Ctrl11 (green)
*/
A[] ((MvC11.InitialGreen || MvC11.ExtGreen || MvC11.GappedOut || MvC11.Rest) imply L11.Green)

/*
Light11 conforms to Ctrl11 (red)
*/
A[] ((MvC11.RedClear || MvC11.RedNoDemand || MvC11.RedWaiting) imply L11.Red)

/*
Light11 conforms to Ctrl11 (red+amber)
*/
A[] (MvC11.RedAmber imply L11.RedAmber)

/*
Light11 conforms to Ctrl11 (amber)
*/
A[] (MvC11.Amber imply L11.Amber)

/*
Liveness for 11 (fol. actuation)
*/
Det11.Actuated --> L11.Green

/*
Liveness for 11 (fol. no service)
*/
!service[M11] --> L11.Green

/*
Initial green length
*/
A[] (L11.Amber imply L11.green_t >= INIT_GREEN)

/*
Light20 conforms to Ctrl20 (green)
*/
A[] ((MvC20.InitialGreen || MvC20.ExtGreen || MvC20.GappedOut || MvC20.Rest) imply L20.Green)

/*
Light20 conforms to Ctrl20 (red)
*/
A[] ((MvC20.RedClear || MvC20.RedNoDemand || MvC20.RedWaiting) imply L20.Red)

/*
Light20 conforms to Ctrl20 (red+amber)
*/
A[] (MvC20.RedAmber imply L20.RedAmber)

/*
Light20 conforms to Ctrl20 (amber)
*/
A[] (MvC20.Amber imply L20.Amber)

/*
Liveness for 20 (fol. actuation)
*/
Det20.Actuated --> L20.Green

/*
Liveness for 20 (fol. no service)
*/
!service[M20] --> L20.Green

/*
Initial green length
*/
A[] (L20.Amber imply L20.green_t >= INIT_GREEN)
