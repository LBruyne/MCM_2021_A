# MCM_2021_A

本人和团队成员在MCM-2021（美国大学生数学建模竞赛，美赛） Problem A中的部分建模解题代码。

Latest revised at 2021.02.13.

本项目所有解题代码均用Matlab2017B进行完成并运行得到结果。



## Descriptions

### Files

- code目录下存放的是各个题目的解体代码，按照题号进行分类
- data目录下是各个题目需要的解题数据，都以.mat的文件形式进行存储，这些数据是我们从各个合法开源网站搜集得到的，不涉及数据来源问题。部分数据进行了预先清洗。
- 附上MCM-2021的A题Problem.pdf



### Uses

- 大部分代码直接使用Matlab可以运行（需要加载到对应的数据文件）
- 部分结果需要对.m中的一些参数进行修改得到



### Thought Threads

- 第一问通过Logistic方程建模得到模型，然后直接解出模型，利用22°下生长速率和分解速率的关系（decomposition_grow_data)数据，代入不同分解速率得到预测出的生长速率，调参以后得到参数的较优解。这一问不是重点，不需要特别精确的解，整体建模即可。
- 第二问通过LV方程进行建模，竞争系数通过moisture_tolerance的相关数据（competititon_coefficients）进行运算得到。然后解出模型的数值解。
- 第三问加入温度和湿度对LV方程的影响，通过22°下的实验室数据计算出模型中各个不同菌种的影响因子k3的数值，然后利用不同温度和湿度下菌种生长速度得数据（moisture_temperature_grow_curve），拟合曲线，并计算正态分布各个参数的数值（moisture_temperature_grow_curve_attributes）,带入模型，算出各个温度和湿度下菌种的理论生长速率。利用Wisconsin（wisconsin_temperature）的2010-2020年温度数据，进行长期和短期的预测。
- 第四问获取美国当地五个不同地区的一年温度数据（other_cities_temperature），然后对不同地区的菌种生长情况进行预测。
- 第五问对不同菌种数量(2,3,14,34)和菌种组合下的生长模型情况进行预测，并计算每种情况下的香农多样性指数和辛普森多样性指数。