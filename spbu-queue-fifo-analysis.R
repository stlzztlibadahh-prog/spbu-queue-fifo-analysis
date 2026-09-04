#==========================================================
#1. MEMANGGIL LIBRARY
#==========================================================
library(readxl)
library(dplyr)
library(psych)
library(ggplot2)
library(goftest)
library(knitr)
library(queueing)
library(goftest)

options(scipen = 999)

#==========================================================
 # 2. IMPORT DATA
#==========================================================
data <- read_excel("D:/SEMESTER 4/PROSES STOKASTIK/Nozzle1_FINAL.xlsx")

interarrival <- data$`Waktu Antar Kedatangan (Detik)`
service      <- data$`Waktu Proses (Detik)`
waiting      <- data$`Waktu Antrian (Detik)`

interarrival <- interarrival[-1]

#==========================================================
#3. STATISTIK DESKRIPTIF
#==========================================================
describe(data[,c(
  "Waktu Antar Kedatangan (Detik)",
  "Waktu Proses (Detik)",
  "Waktu Antrian (Detik)"
)])

summary(data[,c(
  "Waktu Antar Kedatangan (Detik)",
  "Waktu Proses (Detik)",
  "Waktu Antrian (Detik)"
)])

statistik <- data.frame(
  
  Variabel=c(
    "Interarrival",
    "Service",
    "Waiting"
  ),
  
  Mean=c(
    mean(interarrival),
    mean(service),
    mean(waiting)
  ),
  
  SD=c(
    sd(interarrival),
    sd(service),
    sd(waiting)
  ),
  
  Min=c(
    min(interarrival),
    min(service),
    min(waiting)
  ),
  
  Max=c(
    max(interarrival),
    max(service),
    max(waiting)
  )
  
)

kable(statistik,digits=2)

#==========================================================
#4. VISUALISASI
#==========================================================
par(mfrow=c(1,3))

hist(interarrival,
     col="tomato",
     main="Interarrival Time",
     xlab="Detik")

hist(service,
     col="pink",
     main="Service Time",
     xlab="Detik")

hist(waiting,
     col="skyblue",
     main="Waiting Time",
     xlab="Detik")

par(mfrow=c(1,1))

par(mfrow=c(1,3))

boxplot(interarrival,
        col="tomato",
        main="Interarrival")

boxplot(service,
        col="pink",
        main="Service")

boxplot(waiting,
        col="skyblue",
        main="Waiting")

par(mfrow=c(1,1))

#==========================================================
#5. ANALISIS POLA KEDATANGAN
#==========================================================
library(goftest)

lambda <- 1/mean(interarrival)

ad_interarrival <- goftest::ad.test(
  interarrival,
  null = pexp,
  rate = lambda
)

print(ad_interarrival)
lambda <- 1/mean(interarrival)


if(ad_interarrival$p.value>0.05){
  
  arrival <- "M"
  
}else{
  
  arrival <- "G"
  
}

#==========================================================
#6. ANALISIS POLA PELAYANAN
#==========================================================
mu <- 1/mean(service)

Cs2 <- var(service)/(mean(service)^2)

ad_service <- goftest::ad.test(
  service,
  null = pexp,
  rate = mu
)

ad_service

if(ad_service$p.value>0.05){
  
  service.model <- "M"
  
}else{
  
  service.model <- "G"
  
}

#==========================================================
#7. PENENTUAN MODEL
#==========================================================
server <- 2

model <- paste0(
  
  arrival,
  
  "/",
  
  service.model,
  
  "/",
  
  server
  
)

cat(model)

#==========================================================
#8. IDENTIFIKASI PARAMETER
#==========================================================
a <- lambda/mu

rho <- lambda/(server*mu)

parameter <- data.frame(
  
  Parameter=c(
    
    "Lambda",
    
    "Mu",
    
    "Traffic Intensity",
    
    "Rho",
    
    "Cs²"
    
  ),
  
  Nilai=c(
    
    lambda,
    
    mu,
    
    a,
    
    rho,
    
    Cs2
    
  )
  
)

kable(parameter,
      digits=5)

#==========================================================
#9. STABILITAS SISTEM
#==========================================================
if(rho<1){
  
  cat("Sistem Stabil")
  
}else{
  
  cat("Sistem Tidak Stabil")
  
}

#==========================================================
#10. UKURAN KINERJA M/G/2
#==========================================================
P0 <- 1 / (
  sum(sapply(0:(server-1),
             function(n)
               (a^n)/factorial(n)))
  +
    ((a^server)/
       factorial(server))*
    (1/(1-rho))
)

Lq_mm2 <- (P0*(a^server)*rho)/
  (factorial(server)*(1-rho)^2)

Lq <- ((1+Cs2)/2)*Lq_mm2

Ls <- Lq+a

Wq <- Lq/lambda

Ws <- Wq+(1/mu)

#==========================================================
#11. TABEL UKURAN KINERJA
#==========================================================
hasil <- data.frame(
  
  Parameter=c(
    
    "P0",
    
    "Lq",
    
    "Ls",
    
    "Wq",
    
    "Ws"
    
  ),
  
  Nilai=c(
    
    P0,
    
    Lq,
    
    Ls,
    
    Wq,
    
    Ws
    
  )
  
)

kable(
  
  hasil,
  
  digits=5
)
#==========================================================
# INTERPRETASI UKURAN KINERJA
#==========================================================

cat("=====================================\n")
cat("INTERPRETASI UKURAN KINERJA\n")
cat("=====================================\n")

cat("Rata-rata pelanggan dalam antrean (Lq) =", round(Lq,3), "pelanggan\n")

cat("Rata-rata pelanggan dalam sistem (Ls) =", round(Ls,3), "pelanggan\n")

cat("Rata-rata waktu menunggu dalam antrean (Wq) =", round(Wq,3), "detik\n")

cat("Rata-rata waktu dalam sistem (Ws) =", round(Ws,3), "detik\n")
#==========================================================
#12. VISUALISASI UKURAN KINERJA
#==========================================================
ggplot(
  
  hasil,
  
  aes(
    
    Parameter,
    
    Nilai,
    
    fill=Parameter
    
  )
  
)+
  
  geom_col()+
  
  theme_minimal()+
  
  theme(
    
    legend.position="none"
    
  )

#==========================================================
# PEMERIKSAAN STABILITAS SISTEM
#==========================================================

cat("=====================================\n")
cat("PEMERIKSAAN STABILITAS SISTEM\n")
cat("=====================================\n")

cat("Nilai Utilisasi (ρ) =", round(rho,4), "\n")

if (rho < 1) {
  
  cat("Keputusan : Sistem Stabil\n")
  cat("Interpretasi : Laju pelayanan lebih besar daripada laju kedatangan sehingga sistem mampu melayani pelanggan dengan baik.\n")
  
} else if (rho == 1) {
  
  cat("Keputusan : Sistem berada pada kondisi kritis\n")
  cat("Interpretasi : Laju kedatangan sama dengan laju pelayanan sehingga antrean berpotensi terus bertambah.\n")
  
} else {
  
  cat("Keputusan : Sistem Tidak Stabil\n")
  cat("Interpretasi : Laju kedatangan melebihi kemampuan pelayanan sehingga antrean akan terus meningkat.\n")
  
}
#==========================================================
 # 13. DASHBOARD HASIL
#==========================================================
cat("============================\n")

cat("MODEL :",model,"\n")

cat("Lambda :",lambda,"\n")

cat("Mu :",mu,"\n")

cat("Rho :",rho,"\n")

cat("Cs² :",Cs2,"\n")

cat("P0 :",P0,"\n")

cat("Lq :",Lq,"\n")

cat("Ls :",Ls,"\n")

cat("Wq :",Wq,"\n")

cat("Ws :",Ws,"\n")

