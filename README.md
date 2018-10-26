# 資策會 Machine Learn 
10/11 資料清洗段落

# 空值欄位狀況

* LotFrontage:Linear feet of street connected to property             街道連到屋子的距離/缺值259個
* Alley:Type of alley access to property                              連接小巷的路況/缺值1369個(NA是沒巷子)
* MasVnrType:Masonry veneer type                                      牆面類型/類別型/缺值獨立類別/缺值8個(用演算法補)
* MasVnrArea:Masonry veneer area in square feet                       牆面積/缺值8個(用演算法補)
* BsmtQual:Evaluates the height of the basement                       地下室高度/缺值37個(NA是沒地下室)
* BsmtCond:Evaluates the general condition of the basement            地下室狀況/缺值37個(NA是沒地下室)
* BsmtExposure:Refers to walkout or garden level walls                花園牆高/缺值38個(NA是沒花園)
* BsmtFinType1:Rating of basement finished area                       地下室可住性？/缺值37個(NA是沒地下室)
* BsmtFinType2:Rating of basement finished area (if multiple types)   地下室可住性(多類型)/缺值38個(NA是沒地下室,還有一個不知道)
* Electrical:Electrical system                                        電力系統/缺值1個(用演算法補)
* FireplaceQu:Fireplace quality                                       壁爐型式/缺值690個(NA沒壁爐)
* GarageType:Garage location                                          車庫位置/缺值81個(NA就是沒車庫 請補0)
* GarageYrBlt:Year garage was built                                   車庫建成年分/缺值81個(NA就是沒車庫 請補0)
* GarageFinish:Interior finish of the garage                          車庫環境(NA就是沒車庫 都說沒車庫了，填個毛呀！補0！)
* GarageQual:Garage quality                                           車庫品質(NA就是沒...懶得說了)
* GarageCond:Garage condition                                         車庫狀況(NA就...)
* PoolQC:Pool:quality                                                 泳池質量/缺值1453個
* Fence:Fence:quality                                                 圍欄質量/缺值1179個
* MiscFeature:Miscellaneous feature not covered in other categories   雜項功能/缺值1406個


# 2018/10/26
終於找到XGBoosting Regression的使用方法。丟上kaggle.com，得分0.14497，暫時排名2523。可以繼續做特徵選取與PCA降維
