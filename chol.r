
source("/storage/evolgen/R/scripts/GWAS/emma.r")

Y <- read.csv("/storage/evolgen/jan/tens/ara_pheno.csv")
my.X <- read.csv("/storage/evolgen/jan/tens/ara_genos10k.csv")
rownames(my.X) <- my.X[,1]
X <- my.X[,-1]
rownames(Y) <- Y[,1]


load("/storage/evolgen/data/2029_data/K_2029.rda")
K <- K_2029

Y_<-Y[order(Y[,1]),]
Y<-as.matrix(Y_[,2])
rownames(Y)<-as.integer(Y_[,1])
Y<-na.omit(Y)
XX<-X[rownames(X) %in% rownames(Y),]
Y1<-as.matrix(Y[rownames(Y) %in% rownames(XX),])
colnames(Y1)<-colnames(Y)
rownames(Y1)<-rownames(Y)[rownames(Y)%in%rownames(XX)]
ecot_id<-as.integer(rownames(Y1))
K1<-K[rownames(K) %in% ecot_id,]
K2<-K1[,colnames(K1) %in% ecot_id]
K_ok<-as.matrix(K2)
a<-rownames(K_ok)
n<-length(a)
K_stand<-(n-1)/sum((diag(n)-matrix(1,n,n)/n)*K_ok)*K_ok
Y<-Y1[which(rownames(Y1)%in%a),]
X_<-XX[which(rownames(XX)%in%a),]
X_ok <- X_

Xo<-rep(1,nrow(X_ok))
ex<-as.matrix(Xo)

null<-emma.REMLE(Y,ex,K_stand)
herit<-null$vg/(null$vg+null$ve)

M<-solve(chol(null$vg*K_stand+null$ve*diag(dim(K_stand)[1])))
Y_t<-crossprod(M,Y)
int_t<-crossprod(M,(rep(1,length(Y))))

Y2 <- cbind(Y,Y_t)
Y2 <- cbind(as.numeric(rownames(Y2)),Y2)
Y2_ <- Y2[order(Y2[,1],decreasing = TRUE),]

head(Y)
head(Y2_)
Y_<- Y[order(Y[,1],decreasing = TRUE),]
head(Y_)
head(Y2_)
final_y <- cbind(Y_,Y2_[,3])
colnames(final_y)[4] <- "chol"
write.csv(final_y,"/storage/evolgen/jan/tens/ara_chol.csv",row.names=F)
