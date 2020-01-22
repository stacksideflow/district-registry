data = read.csv (text =
"supply, price
10000000000000000000, 0.8530923819791565
22894265887687601542, 1.6153499964097655
23513326773701514153, 1.7004643409539613
23101401440082932974, 1.671334427891629
18101401440082932974, 1.2795073058857578
13101401440082932974, 0.7364629279293717
13101401440082932974, 0.5850445051644338
2810673112874625709, 0.26888420815454017
2810673112874625709, 0.7689847209101061
18218160297661214468, 1.4969450950460992
18218160297661214468, 1.4631305701350708
25736286310833449615, 2.3674131729740937
30382708036273586635, 3.1610997810128847
29495200807961584314, 3.0773424665238918
29495200807961584314, 3.0666516182934873
28386529157918438645, 2.964355814403204
28386529157918438645, 2.4865389206989836
29190860022539606839, 3.0442251711336072
34446713023072391296, 3.7827681293254867
36561566412573295418, 4.117756358204201
37532969198954868491, 4.674595783695262
35383569514554996300, 4.4289175666816485
24383569514554996300, 2.7093449240473317
24383569514554996300, 2.0108538512839633
19367376615289294076, 1.654108807478581
10367376615289294076, 0.6833682495127027
5367376615289294076, 0.19193692627204556
5367376615289294076, 0.503533699539132
19269127394645020716, 1.3429833446483643
22992181757101882581, 1.7867778728603485
25790515045165155872, 2.246282009176294
28906775590993452309, 2.91365021491924
33368532851159403023, 3.8825940619932062
33519728078026000656, 3.898531346757583
20519728078026000656, 2.232456195498206
14519728078026000656, 0.9298251502454411
14519728078026000656, 0.9481591325844831
20847779766612553863, 2.020832410282867
22744691503692469028, 2.161844184812663
2744691503692469028, 0.587282938924575
")

plot(x = data$supply, y = data$price, type = "l")

plot(x = 1:length(data$price), y = data$price, type = "l")

sortedData = data[order(data$supply),]

# plot data with fitted linear reg line
plot(x = sortedData$supply, y = sortedData$price, type = "l")

linearModel <- lm(price ~ supply, data = sortedData)
abline(b = linearModel$coefficients[2], a = linearModel$coefficients[1], col = "red")

expModel <- lm(price ~ supply + I(supply^2), data = sortedData)
lines(sortedData$supply, predict(expModel), lwd = 2, col = "blue")
