// vim: set nospell:
include <nopscadlib/core.scad>
include <constants.scad>
use <nopscadlib/utils/layout.scad>
include <nopscadlib/printed/fan_guard.scad>
include <nopscadlib/vitamins/fans.scad>
use <demo.scad>

// fans = [fan25x10, fan30x10, fan40x11, fan50x15, fan60x15, fan60x25, fan70x15, fan80x25, fan80x38, fan120x25];

module fan_guard_removal(size = 40, thickness = 6){
  difference(){
    rounded_rectangle([size-1,size-1,thickness],7);
    if (size == 40) {
      translate ([0,0,-thickness/2-epsilon])
        fan_guard(fan40x11, name = false, thickness = thickness+epsilon*2, spokes = 4, finger_width = 4, grill = true);
    }
    if (size == 80) {
      translate ([0,0,-thickness/2-1])
        fan_guard(fan80x25, name = false, thickness = thickness+2, spokes = 6, finger_width = 7, grill = true);
      }

    if (size == 120) {
      translate ([0,0,-thickness/2-epsilon])
        fan_guard(fan120x25, name = false, thickness = thickness+epsilon*2, spokes = 8, finger_width = 10, grill = true);
      }
    }
}


module fan_guard_2d(size = 40){
  thickness = 6;
  difference(){
    rounded_rectangle([size-1,size-1,thickness],7);
    if (size == 40) {
      translate ([0,0,-thickness/2-epsilon])
        fan_guard(fan40x11, name = false, thickness = thickness+epsilon*2, spokes = 4, finger_width = 4, grill = true);
    }
    if (size == 80) {
      translate ([0,0,-thickness/2-1])
        fan_guard(fan80x25, name = false, thickness = thickness+2, spokes = 6, finger_width = 7, grill = true);
      }

    if (size == 120) {
      translate ([0,0,-thickness/2-epsilon])
        fan_guard(fan120x25, name = false, thickness = thickness+epsilon*2, spokes = 8, finger_width = 10, grill = true);
      }
    }
}


module fan_guard_2d_fast(size = 40){
  thickness = 6;
    if (size == 40) {
      group() {
      	group() {
      		group() {
      			group() {
      				projection(cut = false, convexity = 0) {
      					group() {
      						difference() {
      							group() {
      								linear_extrude(height = 6, center = true, convexity = 1, scale = [1, 1], $fn = 0, $fa = 6, $fs = 0.25) {
      									group() {
      										offset(r = 7, $fn = 60, $fa = 6, $fs = 0.25) {
      											offset(r = -7, $fn = 60, $fa = 6, $fs = 0.25) {
      												square(size = [39, 39], center = true);
      											}
      										}
      									}
      								}
      							}
      							group() {
      								multmatrix([[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, -3.1], [0, 0, 0, 1]]) {
      									group() {
      										group() {
      											group() {
      												group();
      											}
      										}
      										group() {
      											group() {
      												linear_extrude(height = 6.2, center = false, convexity = 1, scale = [1, 1], $fn = 0, $fa = 6, $fs = 0.25) {
      													group() {
      														difference() {
      															offset(r = -1.5, $fn = 0, $fa = 6, $fs = 0.25) {
      																offset(r = 1.5, $fn = 0, $fa = 6, $fs = 0.25) {
      																	difference() {
      																		group() {
      																			offset(r = 4.2, $fn = 60, $fa = 6, $fs = 0.25) {
      																				offset(r = -4.2, $fn = 60, $fa = 6, $fs = 0.25) {
      																					square(size = [40.4, 40.4], center = true);
      																				}
      																			}
      																		}
      																		group() {
      																			group() {
      																				group() {
      																					group() {
      																						group();
      																						difference() {
      																							intersection() {
      																								square(size = [37, 37], center = true);
      																								circle($fn = 0, $fa = 6, $fs = 0.25, r = 18.5);
      																							}
      																							group();
      																						}
      																					}
      																				}
      																			}
      																		}
      																	}
      																	group() {
      																		intersection() {
      																			union() {
      																				group() {
      																					group() {
      																						difference() {
      																							group() {
      																								circle($fn = 60, $fa = 6, $fs = 0.25, r = 9.5);
      																							}
      																							group() {
      																								circle($fn = 60, $fa = 6, $fs = 0.25, r = 7.5);
      																							}
      																						}
      																					}
      																					group() {
      																						difference() {
      																							group() {
      																								circle($fn = 60, $fa = 6, $fs = 0.25, r = 15);
      																							}
      																							group() {
      																								circle($fn = 60, $fa = 6, $fs = 0.25, r = 13);
      																							}
      																						}
      																					}
      																				}
      																				group() {
      																					multmatrix([[0.707107, -0.707107, 0, 0], [0.707107, 0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																						multmatrix([[1, 0, 0, 8.5], [0, 1, 0, -1.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																							square(size = [10.0078, 3], center = false);
      																						}
      																					}
      																					multmatrix([[-0.707107, -0.707107, 0, 0], [0.707107, -0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																						multmatrix([[1, 0, 0, 8.5], [0, 1, 0, -1.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																							square(size = [10.0078, 3], center = false);
      																						}
      																					}
      																					multmatrix([[-0.707107, 0.707107, 0, 0], [-0.707107, -0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																						multmatrix([[1, 0, 0, 8.5], [0, 1, 0, -1.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																							square(size = [10.0078, 3], center = false);
      																						}
      																					}
      																					multmatrix([[0.707107, 0.707107, 0, 0], [-0.707107, 0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																						multmatrix([[1, 0, 0, 8.5], [0, 1, 0, -1.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																							square(size = [10.0078, 3], center = false);
      																						}
      																					}
      																				}
      																			}
      																			square(size = [40.3922, 40.3922], center = true);
      																		}
      																	}
      																}
      															}
      															group() {
      																group() {
      																	group() {
      																		group() {
      																			multmatrix([[1, 0, 0, -16], [0, 1, 0, -16], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																				group() {
      																					group() {
      																						group() {
      																							group() {
      																								group() {
      																									circle($fn = 0, $fa = 6, $fs = 0.25, r = 1.65463);
      																								}
      																							}
      																						}
      																					}
      																				}
      																			}
      																			multmatrix([[1, 0, 0, -16], [0, 1, 0, 16], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																				group() {
      																					group() {
      																						group() {
      																							group() {
      																								group() {
      																									circle($fn = 0, $fa = 6, $fs = 0.25, r = 1.65463);
      																								}
      																							}
      																						}
      																					}
      																				}
      																			}
      																		}
      																		group() {
      																			multmatrix([[1, 0, 0, 16], [0, 1, 0, -16], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																				group() {
      																					group() {
      																						group() {
      																							group() {
      																								group() {
      																									circle($fn = 0, $fa = 6, $fs = 0.25, r = 1.65463);
      																								}
      																							}
      																						}
      																					}
      																				}
      																			}
      																			multmatrix([[1, 0, 0, 16], [0, 1, 0, 16], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																				group() {
      																					group() {
      																						group() {
      																							group() {
      																								group() {
      																									circle($fn = 0, $fa = 6, $fs = 0.25, r = 1.65463);
      																								}
      																							}
      																						}
      																					}
      																				}
      																			}
      																		}
      																	}
      																}
      															}
      														}
      														group() {
      															difference() {
      																circle($fn = 0, $fa = 6, $fs = 0.25, r = 8.5);
      																group() {
      																	multmatrix([[0.707107, -0.707107, 0, 0], [0.707107, 0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																		multmatrix([[1, 0, 0, 4.25], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																			circle($fn = 0, $fa = 6, $fs = 0.25, r = 2);
      																		}
      																	}
      																	multmatrix([[-0.707107, -0.707107, 0, 0], [0.707107, -0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																		multmatrix([[1, 0, 0, 4.25], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																			circle($fn = 0, $fa = 6, $fs = 0.25, r = 2);
      																		}
      																	}
      																	multmatrix([[-0.707107, 0.707107, 0, 0], [-0.707107, -0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																		multmatrix([[1, 0, 0, 4.25], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																			circle($fn = 0, $fa = 6, $fs = 0.25, r = 2);
      																		}
      																	}
      																	multmatrix([[0.707107, 0.707107, 0, 0], [-0.707107, 0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																		multmatrix([[1, 0, 0, 4.25], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																			circle($fn = 0, $fa = 6, $fs = 0.25, r = 2);
      																		}
      																	}
      																}
      															}
      														}
      													}
      												}
      											}
      										}
      									}
      								}
      							}
      							group();
      							group();
      						}
      					}
      				}
      			}
      		}
      	}
      }


    }
    if (size == 80) {
      group() {
      	group() {
      		group() {
      			group() {
      				projection(cut = false, convexity = 0) {
      					group() {
      						difference() {
      							group() {
      								linear_extrude(height = 6, center = true, convexity = 1, scale = [1, 1], $fn = 0, $fa = 6, $fs = 0.25) {
      									group() {
      										offset(r = 7, $fn = 60, $fa = 6, $fs = 0.25) {
      											offset(r = -7, $fn = 60, $fa = 6, $fs = 0.25) {
      												square(size = [79, 79], center = true);
      											}
      										}
      									}
      								}
      							}
      							group();
      							group() {
      								multmatrix([[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, -4], [0, 0, 0, 1]]) {
      									group() {
      										group() {
      											group() {
      												group();
      											}
      										}
      										group() {
      											group() {
      												linear_extrude(height = 8, center = false, convexity = 1, scale = [1, 1], $fn = 0, $fa = 6, $fs = 0.25) {
      													group() {
      														difference() {
      															offset(r = -1.5, $fn = 0, $fa = 6, $fs = 0.25) {
      																offset(r = 1.5, $fn = 0, $fa = 6, $fs = 0.25) {
      																	difference() {
      																		group() {
      																			offset(r = 5, $fn = 60, $fa = 6, $fs = 0.25) {
      																				offset(r = -5, $fn = 60, $fa = 6, $fs = 0.25) {
      																					square(size = [81.5, 81.5], center = true);
      																				}
      																			}
      																		}
      																		group() {
      																			group() {
      																				group() {
      																					group() {
      																						group();
      																						difference() {
      																							intersection() {
      																								square(size = [75, 75], center = true);
      																								circle($fn = 0, $fa = 6, $fs = 0.25, r = 42.5);
      																							}
      																							group();
      																						}
      																					}
      																				}
      																			}
      																		}
      																	}
      																	group() {
      																		intersection() {
      																			union() {
      																				group() {
      																					group() {
      																						difference() {
      																							group() {
      																								circle($fn = 60, $fa = 6, $fs = 0.25, r = 13.3);
      																							}
      																							group() {
      																								circle($fn = 60, $fa = 6, $fs = 0.25, r = 11.3);
      																							}
      																						}
      																					}
      																					group() {
      																						difference() {
      																							group() {
      																								circle($fn = 60, $fa = 6, $fs = 0.25, r = 21.1);
      																							}
      																							group() {
      																								circle($fn = 60, $fa = 6, $fs = 0.25, r = 19.1);
      																							}
      																						}
      																					}
      																					group() {
      																						difference() {
      																							group() {
      																								circle($fn = 60, $fa = 6, $fs = 0.25, r = 28.9);
      																							}
      																							group() {
      																								circle($fn = 60, $fa = 6, $fs = 0.25, r = 26.9);
      																							}
      																						}
      																					}
      																					group() {
      																						difference() {
      																							group() {
      																								circle($fn = 60, $fa = 6, $fs = 0.25, r = 36.7);
      																							}
      																							group() {
      																								circle($fn = 60, $fa = 6, $fs = 0.25, r = 34.7);
      																							}
      																						}
      																					}
      																				}
      																				group() {
      																					multmatrix([[0.707107, -0.707107, 0, 0], [0.707107, 0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																						multmatrix([[1, 0, 0, 12.3], [0, 1, 0, -1.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																							square(size = [22.4078, 3], center = false);
      																						}
      																					}
      																					multmatrix([[-0.258819, -0.965926, 0, 0], [0.965926, -0.258819, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																						multmatrix([[1, 0, 0, 12.3], [0, 1, 0, -1.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																							square(size = [22.4078, 3], center = false);
      																						}
      																					}
      																					multmatrix([[-0.965926, -0.258819, 0, 0], [0.258819, -0.965926, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																						multmatrix([[1, 0, 0, 12.3], [0, 1, 0, -1.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																							square(size = [22.4078, 3], center = false);
      																						}
      																					}
      																					multmatrix([[-0.707107, 0.707107, 0, 0], [-0.707107, -0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																						multmatrix([[1, 0, 0, 12.3], [0, 1, 0, -1.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																							square(size = [22.4078, 3], center = false);
      																						}
      																					}
      																					multmatrix([[0.258819, 0.965926, 0, 0], [-0.965926, 0.258819, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																						multmatrix([[1, 0, 0, 12.3], [0, 1, 0, -1.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																							square(size = [22.4078, 3], center = false);
      																						}
      																					}
      																					multmatrix([[0.965926, 0.258819, 0, 0], [-0.258819, 0.965926, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																						multmatrix([[1, 0, 0, 12.3], [0, 1, 0, -1.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																							square(size = [22.4078, 3], center = false);
      																						}
      																					}
      																				}
      																			}
      																			square(size = [81.4922, 81.4922], center = true);
      																		}
      																	}
      																}
      															}
      															group() {
      																group() {
      																	group() {
      																		group() {
      																			multmatrix([[1, 0, 0, -35.75], [0, 1, 0, -35.75], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																				group() {
      																					group() {
      																						group() {
      																							group() {
      																								group() {
      																									circle($fn = 0, $fa = 6, $fs = 0.25, r = 2.20347);
      																								}
      																							}
      																						}
      																					}
      																				}
      																			}
      																			multmatrix([[1, 0, 0, -35.75], [0, 1, 0, 35.75], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																				group() {
      																					group() {
      																						group() {
      																							group() {
      																								group() {
      																									circle($fn = 0, $fa = 6, $fs = 0.25, r = 2.20347);
      																								}
      																							}
      																						}
      																					}
      																				}
      																			}
      																		}
      																		group() {
      																			multmatrix([[1, 0, 0, 35.75], [0, 1, 0, -35.75], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																				group() {
      																					group() {
      																						group() {
      																							group() {
      																								group() {
      																									circle($fn = 0, $fa = 6, $fs = 0.25, r = 2.20347);
      																								}
      																							}
      																						}
      																					}
      																				}
      																			}
      																			multmatrix([[1, 0, 0, 35.75], [0, 1, 0, 35.75], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																				group() {
      																					group() {
      																						group() {
      																							group() {
      																								group() {
      																									circle($fn = 0, $fa = 6, $fs = 0.25, r = 2.20347);
      																								}
      																							}
      																						}
      																					}
      																				}
      																			}
      																		}
      																	}
      																}
      															}
      														}
      														group() {
      															difference() {
      																circle($fn = 0, $fa = 6, $fs = 0.25, r = 12.3);
      																group() {
      																	multmatrix([[0.707107, -0.707107, 0, 0], [0.707107, 0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																		multmatrix([[1, 0, 0, 6.15], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																			circle($fn = 0, $fa = 6, $fs = 0.25, r = 2);
      																		}
      																	}
      																	multmatrix([[-0.707107, -0.707107, 0, 0], [0.707107, -0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																		multmatrix([[1, 0, 0, 6.15], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																			circle($fn = 0, $fa = 6, $fs = 0.25, r = 2);
      																		}
      																	}
      																	multmatrix([[-0.707107, 0.707107, 0, 0], [-0.707107, -0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																		multmatrix([[1, 0, 0, 6.15], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																			circle($fn = 0, $fa = 6, $fs = 0.25, r = 2);
      																		}
      																	}
      																	multmatrix([[0.707107, 0.707107, 0, 0], [-0.707107, 0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																		multmatrix([[1, 0, 0, 6.15], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																			circle($fn = 0, $fa = 6, $fs = 0.25, r = 2);
      																		}
      																	}
      																}
      															}
      														}
      													}
      												}
      											}
      										}
      									}
      								}
      							}
      							group();
      						}
      					}
      				}
      			}
      		}
      	}
      }


      }

    if (size == 120) {
      projection(cut = false, convexity = 0) {
      	group() {
      		difference() {
      			group() {
      				linear_extrude(height = 6, center = true, convexity = 1, scale = [1, 1], $fn = 0, $fa = 6, $fs = 0.25) {
      					group() {
      						offset(r = 7, $fn = 60, $fa = 6, $fs = 0.25) {
      							offset(r = -7, $fn = 60, $fa = 6, $fs = 0.25) {
      								square(size = [119, 119], center = true);
      							}
      						}
      					}
      				}
      			}
      			group();
      			group();
      			group() {
      				multmatrix([[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, -3.1], [0, 0, 0, 1]]) {
      					group() {
      						group() {
      							group() {
      								group();
      							}
      						}
      						group() {
      							group() {
      								linear_extrude(height = 6.2, center = false, convexity = 1, scale = [1, 1], $fn = 0, $fa = 6, $fs = 0.25) {
      									group() {
      										difference() {
      											offset(r = -1.5, $fn = 0, $fa = 6, $fs = 0.25) {
      												offset(r = 1.5, $fn = 0, $fa = 6, $fs = 0.25) {
      													difference() {
      														group() {
      															offset(r = 7.2, $fn = 60, $fa = 6, $fs = 0.25) {
      																offset(r = -7.2, $fn = 60, $fa = 6, $fs = 0.25) {
      																	square(size = [119.4, 119.4], center = true);
      																}
      															}
      														}
      														group() {
      															group() {
      																group() {
      																	group() {
      																		group();
      																		difference() {
      																			intersection() {
      																				square(size = [116, 116], center = true);
      																				circle($fn = 0, $fa = 6, $fs = 0.25, r = 68.5);
      																			}
      																			group();
      																		}
      																	}
      																}
      															}
      														}
      													}
      													group() {
      														intersection() {
      															union() {
      																group() {
      																	group() {
      																		difference() {
      																			group() {
      																				circle($fn = 60, $fa = 6, $fs = 0.25, r = 17.5833);
      																			}
      																			group() {
      																				circle($fn = 60, $fa = 6, $fs = 0.25, r = 15.5833);
      																			}
      																		}
      																	}
      																	group() {
      																		difference() {
      																			group() {
      																				circle($fn = 60, $fa = 6, $fs = 0.25, r = 28.1667);
      																			}
      																			group() {
      																				circle($fn = 60, $fa = 6, $fs = 0.25, r = 26.1667);
      																			}
      																		}
      																	}
      																	group() {
      																		difference() {
      																			group() {
      																				circle($fn = 60, $fa = 6, $fs = 0.25, r = 38.75);
      																			}
      																			group() {
      																				circle($fn = 60, $fa = 6, $fs = 0.25, r = 36.75);
      																			}
      																		}
      																	}
      																	group() {
      																		difference() {
      																			group() {
      																				circle($fn = 60, $fa = 6, $fs = 0.25, r = 49.3333);
      																			}
      																			group() {
      																				circle($fn = 60, $fa = 6, $fs = 0.25, r = 47.3333);
      																			}
      																		}
      																	}
      																	group() {
      																		difference() {
      																			group() {
      																				circle($fn = 60, $fa = 6, $fs = 0.25, r = 59.9167);
      																			}
      																			group() {
      																				circle($fn = 60, $fa = 6, $fs = 0.25, r = 57.9167);
      																			}
      																		}
      																	}
      																}
      																group() {
      																	multmatrix([[0.707107, -0.707107, 0, 0], [0.707107, 0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																		multmatrix([[1, 0, 0, 16.5833], [0, 1, 0, -1.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																			square(size = [41.3411, 3], center = false);
      																		}
      																	}
      																	multmatrix([[0, -1, 0, 0], [1, 0, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																		multmatrix([[1, 0, 0, 16.5833], [0, 1, 0, -1.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																			square(size = [41.3411, 3], center = false);
      																		}
      																	}
      																	multmatrix([[-0.707107, -0.707107, 0, 0], [0.707107, -0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																		multmatrix([[1, 0, 0, 16.5833], [0, 1, 0, -1.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																			square(size = [41.3411, 3], center = false);
      																		}
      																	}
      																	multmatrix([[-1, 0, 0, 0], [0, -1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																		multmatrix([[1, 0, 0, 16.5833], [0, 1, 0, -1.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																			square(size = [41.3411, 3], center = false);
      																		}
      																	}
      																	multmatrix([[-0.707107, 0.707107, 0, 0], [-0.707107, -0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																		multmatrix([[1, 0, 0, 16.5833], [0, 1, 0, -1.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																			square(size = [41.3411, 3], center = false);
      																		}
      																	}
      																	multmatrix([[0, 1, 0, 0], [-1, 0, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																		multmatrix([[1, 0, 0, 16.5833], [0, 1, 0, -1.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																			square(size = [41.3411, 3], center = false);
      																		}
      																	}
      																	multmatrix([[0.707107, 0.707107, 0, 0], [-0.707107, 0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																		multmatrix([[1, 0, 0, 16.5833], [0, 1, 0, -1.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																			square(size = [41.3411, 3], center = false);
      																		}
      																	}
      																	multmatrix([[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																		multmatrix([[1, 0, 0, 16.5833], [0, 1, 0, -1.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																			square(size = [41.3411, 3], center = false);
      																		}
      																	}
      																}
      															}
      															square(size = [119.392, 119.392], center = true);
      														}
      													}
      												}
      											}
      											group() {
      												group() {
      													group() {
      														group() {
      															multmatrix([[1, 0, 0, -52.5], [0, 1, 0, -52.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																group() {
      																	group() {
      																		group() {
      																			group() {
      																				group() {
      																					circle($fn = 0, $fa = 6, $fs = 0.25, r = 2.20347);
      																				}
      																			}
      																		}
      																	}
      																}
      															}
      															multmatrix([[1, 0, 0, -52.5], [0, 1, 0, 52.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																group() {
      																	group() {
      																		group() {
      																			group() {
      																				group() {
      																					circle($fn = 0, $fa = 6, $fs = 0.25, r = 2.20347);
      																				}
      																			}
      																		}
      																	}
      																}
      															}
      														}
      														group() {
      															multmatrix([[1, 0, 0, 52.5], [0, 1, 0, -52.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																group() {
      																	group() {
      																		group() {
      																			group() {
      																				group() {
      																					circle($fn = 0, $fa = 6, $fs = 0.25, r = 2.20347);
      																				}
      																			}
      																		}
      																	}
      																}
      															}
      															multmatrix([[1, 0, 0, 52.5], [0, 1, 0, 52.5], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      																group() {
      																	group() {
      																		group() {
      																			group() {
      																				group() {
      																					circle($fn = 0, $fa = 6, $fs = 0.25, r = 2.20347);
      																				}
      																			}
      																		}
      																	}
      																}
      															}
      														}
      													}
      												}
      											}
      										}
      										group() {
      											difference() {
      												circle($fn = 0, $fa = 6, $fs = 0.25, r = 16.5833);
      												group() {
      													multmatrix([[0.707107, -0.707107, 0, 0], [0.707107, 0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      														multmatrix([[1, 0, 0, 8.29167], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      															circle($fn = 0, $fa = 6, $fs = 0.25, r = 2);
      														}
      													}
      													multmatrix([[-0.707107, -0.707107, 0, 0], [0.707107, -0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      														multmatrix([[1, 0, 0, 8.29167], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      															circle($fn = 0, $fa = 6, $fs = 0.25, r = 2);
      														}
      													}
      													multmatrix([[-0.707107, 0.707107, 0, 0], [-0.707107, -0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      														multmatrix([[1, 0, 0, 8.29167], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      															circle($fn = 0, $fa = 6, $fs = 0.25, r = 2);
      														}
      													}
      													multmatrix([[0.707107, 0.707107, 0, 0], [-0.707107, 0.707107, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      														multmatrix([[1, 0, 0, 8.29167], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]) {
      															circle($fn = 0, $fa = 6, $fs = 0.25, r = 2);
      														}
      													}
      												}
      											}
      										}
      									}
      								}
      							}
      						}
      					}
      				}
      			}
      		}
      	}
      }


      }

}



demo() {
  fan_guard_2d_fast(size = 120);
}
