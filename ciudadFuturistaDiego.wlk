object ciudadFuturista{
    var dronesEnEscuadron = 10
    method maximoPermitido() = dronesEnEscuadron
}
object zona {
  const tamanio = 0
  var cantidadOperacionesRecibida = 0
  method consultarTamanio() = tamanio
  method registrarOperacion(){
    cantidadOperacionesRecibida += 1
  }
}
class Escuadron {
    const dronesPertenecientes = []
    method operarSobre(unaZona){
        return dronesPertenecientes.all({d=>d.esAvanzado()}) && 
        self.capacidadOperativa() > unaZona.consultarTamanio() /2
        zona.registrarOperacion()
        self.disminuyenAutonomia()
    }
    method disminuyenAutonomia(){
        dronesPertenecientes.forEach({d=>d.disminuirAutonomiaPorOperar()})
    }
    method capacidadOperativa() {
      return dronesPertenecientes.sum({d=>d.eficienciaOperativa()})
    }
    method agregarAlEscuadron(unDron){
        if (ciudadFuturista.maximoPermitido() >= dronesPertenecientes){
            self.error("supera el maximo permitido por ciudad")
        }
        else{dronesPertenecientes.add(unDron)}
        
    }
}

class Dron {
    const autonomia = 0
    const nivelProcesamiento = 0
    var misionAsignada = transporte
    method consultarAutonomia() = autonomia
    method disminuirAutonomiaPorOperar(){
        autonomia * 0.5
    } 
    method cambiarMision(nuevaMision){
        misionAsignada = nuevaMision
        }
    method eficienciaOperativa(){
        return autonomia * 10 + self.condicionExtra()
    }
    method condicionExtra()
    method esAvanzado(){
        return self.esAvanzadoPorTipo() || misionAsignada.exigencia(self)
    }
    method esAvanzadoPorTipo()
}
class Comercial inherits Dron {
    override method eficienciaOperativa(){
        return super() * 1.1
    }
    override method esAvanzadoPorTipo() = false
}
class Seguridad inherits Dron {
    override method esAvanzadoPorTipo(){
        nivelProcesamiento > 50
    }
}
object transporte{
    method condicionExtra(){
        return 100
    }
    method exigencia(dronAvanzando){
        dronAvanzando.consultarAutonomia() > 50
    }
}
object exploracion{
    method condicionExtra(){
        return 0
    }
    method exigencia(dronAvanzado){
        dronAvanzado.eficienciaOperativa().even()
    }
}
object vigilancia{
    const sensores = []
    method condicionExtra(){
        sensores.eficiencia()
    }
    method exigencia(dronAvanzando){
        sensores.all({s=>s.esDuradero()})
    }
}
class Sensor {
    const capacidad = 0
    const durabilidad = 0
    const mejoraTecnologica = true
    method cuentaConMejoraTecnologia() = mejoraTecnologica
    method eficiencia(){
        if (!self.cuentaConMejoraTecnologia()){
            return capacidad
        }
        else {return capacidad * 2}
    }
    method esDuradero(){
        return durabilidad > capacidad * 2
    }
}