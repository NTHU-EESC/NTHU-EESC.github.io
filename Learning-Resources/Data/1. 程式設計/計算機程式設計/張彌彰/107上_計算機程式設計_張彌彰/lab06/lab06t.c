nt solution[8];
bool my[8], md1[15], md2[15];   // 初始值都是 false
                                // x這條線可以不用檢查了
								 
								 void backtrack(int x)   // 每次都換一排格子
								 {
								     // it's a solution
									     if (x == 8)
										     {
											         print_solution();
													         return;
															     }
																  
																      // 分別放置皇后在每一格，並各自遞迴下去。
																	      for (int y=0; y<8; ++y)
																		      {
																			          int d1 = (x+y) % 15, d2 = (x-y+15) % 15;
																					   
																					           if (!my[y] && !md1[d1] && !md2[d2])
																							           {
																									               // 這隻皇后佔據了四條線，記得標記起來。
																												               my[y] = md1[d1] = md2[d2] = true;
																															    
																																            solution[x] = y;
																																			            backtrack(x+1);
																																						 
																																						             // 遞迴結束，回復到原本的樣子，要記得取消標記。
																																									             my[y] = md1[d1] = md2[d2] = false;
																																												         }
																																														     }
																																															 }
