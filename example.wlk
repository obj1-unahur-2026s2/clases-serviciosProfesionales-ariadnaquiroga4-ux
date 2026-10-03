object pepita {
  var energy = 100
  method energy() = energy
  method fly(minutes) {
    energy = energy - minutes * 3
  }
}

class Profesional {
  var universidad
  method universidad() = universidad
  method honorariosPorHora() {}
  method provincias() {}
  method cobros(importe) {}
}
class Universidad {
  var provincias
  var honorariosPorHora
  var donacionTotal = 0
  method provincias() = provincias
  method honorariosPorHora() = honorariosPorHora
  method recibirDonacion(importe) {
    donacionTotal += importe
  }
} //const unahur = new Universidad(provincias = "Buenos Aires", honorariosPorHora = 1000)
class ProfesionalesVinculadosAUniversidad inherits Profesional {
  override method honorariosPorHoras() = universidad().honorariosPorHora()
  override method provincias() = [universidad().provincias()]
  override method cobros(importe) {
    universidad().recibirDonacion(importe / 2)
  }
} //const pedro = new ProfesionalesVinculadosAUniversidad(universidad = unahur)
class ProfesionalAsociadosLitoral inherits Profesional {
  override method honorariosPorHoras() = 3000
  override method provincias() = ["Entre Rios", "Santa Fe", "Corrientes"]
  override method cobros(importe) {
    asociacionProfesionalesLitoral.recibir(importe)
  }
} //const juan = new ProfesionalAsociadosLitoral(universidad = unahur) solo se pone universidad el resto de lo que dice el method
object asociacionProfesionalesLitoral {
  var totalRecaudado = 0
  method recibir(importe) {
    totalRecaudado += importe
  }
}
class ProfesionalLibre inherits Profesional {
  var provincias 
  var honorariosPorHora
  var totalRecaudado = 0
  override method honorariosPorHoras() = honorariosPorHora
  override method provincias() = provincias
  override method cobros(importe) {
    totalRecaudado += importe
  }
  method transferir(importe, profesional) {
    totalRecaudado -= importe
    profesional.cobros(importe)
  }
} //const pedro = new ProfesionalLibre(universidad = unahur,provincias = ["Buenos Aires", "Santa Fe"], honorariosPorHora = 2000)

class Empresa {
  var profesionales = []
  var honorariosPorHora
  method honorariosPorHora() = honorariosPorHora
  method estudiaronEnUniversidad(universidad) {
    return profesionales.filter({p => p.universidad() == universidad}).size()
  }
  method profesionalesCaros(hono) {
    return profesionales.filter({p => p.honorariosPorHora() > hono})
  }
  method universidadesFormadas() {
    return profesionales.map({p => p.universidad()}).toSet()
  }
  method masBarato() {
    return profesionales.min({p => p.honorariosPorHora()})
  }
  method esDeGenteAcotada() {
    return profesionales.all({p => p.provincias().size() <= 3})
  }
  method satisfacer(solicitante) {
    return profesionales.any({p => solicitante.atendidoPorProfesional(p)})
  }
}

class solicitantes {
  method atendidoPorProfesional() {}
}
class persona inherits solicitantes{
  var provincia
  method provincia() = provincia
  override method atendidoPorProfesional(profesional) {
    return profesional.provincias() == self.provincia()
  }
}
class institucion inherits solicitantes {
  var universidades = []
  override method atendidoPorProfesional(profesionales) {
    return profesionales.any({p => p.universidad().contains(universidades)})
  }
}
object club inherits solicitantes {
  var provincias = []
  override method atendidoPorProfesional(profesionales) {
    return profesionales.any({p => p.provincias().contains(provincias)})
  }
}

