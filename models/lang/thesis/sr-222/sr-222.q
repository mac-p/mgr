//This file was generated from (Academic) UPPAAL 4.1.3 (rev. 4577), September 2010

/*
Phase agrees with Mvmt (Inactivity-->Red)
*/
A[] PC0.Inactive imply (MvC00.RedNoDemand||MvC00.RedGotCall)\


/*
Mvmt agrees with Light (on Green)
*/
A[] (MvC00.InitGreen||MvC00.ExtGreen||MvC00.GappedOut||MvC00.Rest) imply L00.Green\


/*

*/
A[] (PC0.Active + PC1.Active + PC2.Active <= 1)

/*
Bounded liveness (geq)
*/
A[] (MvC00.v_dem imply MvC00.wait_t <= 55)

/*
Bounded liveness (ge)
*/
A[] (MvC00.v_dem imply MvC00.wait_t < 55)

/*
No deadlock
*/
A[] not deadlock

/*

*/
Det00.Actuated --> L00.Green
