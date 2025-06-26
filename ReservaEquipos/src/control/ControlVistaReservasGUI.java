package control;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.List;
import javax.swing.JOptionPane;

import vista.VistaReservasGUI;

import modelo.Reserva;
import modelo.ReservaDAO;
import modelo.Profesor;
import modelo.ProfesorDAO;
import modelo.Estudiante;
import modelo.EstudianteDAO;
import modelo.EquipoComputo;
import modelo.EquipoComputoDAO;

public class ControlVistaReservasGUI implements ActionListener {
    private VistaReservasGUI vistaReservas;
    private Reserva unaReserva;
    private ReservaDAO unaReservaDAO;
    private ProfesorDAO unProfeDAO;
    private EstudianteDAO unEstDAO;
    private EquipoComputoDAO unPcDAO;
    private List<Profesor> listadoProfesores;
    private List<Estudiante> listadoEstudiantes;
    private List<EquipoComputo> listadoEquiposComputo;

    public ControlVistaReservasGUI() {
        unaReserva = new Reserva();
        unaReservaDAO = new ReservaDAO();
        unProfeDAO = new ProfesorDAO();
        listadoProfesores = unProfeDAO.listarProfesores();
        unEstDAO = new EstudianteDAO();
        listadoEstudiantes = unEstDAO.listarEstudiantes();
        unPcDAO = new EquipoComputoDAO();
        listadoEquiposComputo = unPcDAO.listarEquipoComputo();

        vistaReservas = new VistaReservasGUI();
        vistaReservas.jComb_profesores.removeAllItems();
        vistaReservas.jComb_estudiantes.removeAllItems();
        vistaReservas.jComb_equipoComputo.removeAllItems();
        for (Profesor profe : listadoProfesores) {
            vistaReservas.jComb_profesores.addItem(profe);
        }
        for (Estudiante est : listadoEstudiantes) {
            vistaReservas.jComb_estudiantes.addItem(est);
        }
        for (EquipoComputo pc : listadoEquiposComputo) {
            vistaReservas.jComb_equipoComputo.addItem(pc);
        }
        vistaReservas.jComb_profesores.setEnabled(false);
        vistaReservas.jComb_estudiantes.setEnabled(false);
        vistaReservas.jComb_tipoPersona.setSelectedIndex(-1);
        vistaReservas.jComb_tipoPersona.addActionListener(e -> {
            String tipo = (String) vistaReservas.jComb_tipoPersona.getSelectedItem();
            if ("Profesor".equals(tipo)) {
                vistaReservas.jComb_profesores.setEnabled(true);
                vistaReservas.jComb_estudiantes.setEnabled(false);
                vistaReservas.jComb_estudiantes.setSelectedIndex(-1);
            } else if ("Estudiante".equals(tipo)) {
                vistaReservas.jComb_estudiantes.setEnabled(true);
                vistaReservas.jComb_profesores.setEnabled(false);
                vistaReservas.jComb_profesores.setSelectedIndex(-1);
            } else {
                vistaReservas.jComb_profesores.setEnabled(false);
                vistaReservas.jComb_estudiantes.setEnabled(false);
            }
        });

        vistaReservas.jbtn_agregar.addActionListener(this);
        vistaReservas.btn_ConsultarReservas.addActionListener(this);
        vistaReservas.btn_ListarReservas.addActionListener(this);

        vistaReservas.setVisible(true);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == vistaReservas.jbtn_agregar) {
            String tipo = (String) vistaReservas.jComb_tipoPersona.getSelectedItem();
            if (tipo == null) {
                JOptionPane.showMessageDialog(null, "Seleccione si es profesor o estudiante");
                return;
            }
            int idPersona;
            if ("Estudiante".equals(tipo)) {
                if (vistaReservas.jComb_estudiantes.getSelectedIndex() < 0) {
                    JOptionPane.showMessageDialog(null, "Seleccione un estudiante");
                    return;
                }
                idPersona = ((Estudiante) vistaReservas.jComb_estudiantes.getSelectedItem()).getCodigo();
            } else {
                if (vistaReservas.jComb_profesores.getSelectedIndex() < 0) {
                    JOptionPane.showMessageDialog(null, "Seleccione un profesor");
                    return;
                }
                idPersona = ((Profesor) vistaReservas.jComb_profesores.getSelectedItem()).getCedula();
            }
            int inventario = ((EquipoComputo) vistaReservas.jComb_equipoComputo.getSelectedItem()).getNumInvetario();
            unaReserva.setCedulaProfesor(idPersona);
            unaReserva.setNoInventarioPC(inventario);
            if (unaReservaDAO.insertarReserva(unaReserva)) {
                JOptionPane.showMessageDialog(null, "reserva registrada con exito\ncodigo: " + unaReserva.getCodigo());
            } else {
                JOptionPane.showMessageDialog(null, "reserva no registrada");
            }
        }
        if (e.getSource() == vistaReservas.btn_ConsultarReservas) {
            String cod = vistaReservas.Jtf_ConsultarReservas.getText().trim();
            if (!cod.matches("\\d+")) {
                JOptionPane.showMessageDialog(null, "codigo invalido");
                return;
            }
            int codigo = Integer.parseInt(cod);
            Reserva r = unaReservaDAO.consultarReserva(codigo);
            if (r.getCodigo() == 0) {
                JOptionPane.showMessageDialog(null, "reserva no encontrada");
                return;
            }
            String nombre = "", apellido = "", marca = "";
            Profesor p = unProfeDAO.consultarProfesor(r.getCedulaProfesor());
            if (p != null && p.getCedula() != 0) {
                nombre = p.getNombre();
                apellido = p.getApellido();
                vistaReservas.jComb_tipoPersona.setSelectedItem("Profesor");
                vistaReservas.jComb_profesores.setSelectedItem(p);
            } else {
                Estudiante es = unEstDAO.consultarEstudiante(r.getCedulaProfesor());
                if (es != null && es.getCodigo() != 0) {
                    nombre = es.getNombre();
                    apellido = es.getApellido();
                    vistaReservas.jComb_tipoPersona.setSelectedItem("Estudiante");
                    vistaReservas.jComb_estudiantes.setSelectedItem(es);
                }
            }
            EquipoComputo pc = unPcDAO.consultarEquipoComputo(r.getNoInventarioPC());
            if (pc != null) {
                marca = pc.getMarca();
                vistaReservas.jComb_equipoComputo.setSelectedItem(pc);
            }
            String mensaje = "Codigo: " + r.getCodigo() + "\n" +
                    "Persona: " + nombre + " " + apellido + " (" + r.getCedulaProfesor() + ")\n" +
                    "Equipo: " + marca + "\n" +
                    "Recogida: " + r.getFechaRecogida() + "\n" +
                    "Entrega: " + r.getFechaEntrega();
            JOptionPane.showMessageDialog(null, mensaje);
        }
        if (e.getSource() == vistaReservas.btn_ListarReservas) {
            List<Reserva> lista = unaReservaDAO.listarReservas();
            StringBuilder sb = new StringBuilder();
            for (Reserva r : lista) {
                String nombre = "", apellido = "", marca = "";
                Profesor p = unProfeDAO.consultarProfesor(r.getCedulaProfesor());
                if (p != null && p.getCedula() != 0) {
                    nombre = p.getNombre();
                    apellido = p.getApellido();
                } else {
                    Estudiante es = unEstDAO.consultarEstudiante(r.getCedulaProfesor());
                    if (es != null && es.getCodigo() != 0) {
                        nombre = es.getNombre();
                        apellido = es.getApellido();
                    }
                }
                EquipoComputo pc = unPcDAO.consultarEquipoComputo(r.getNoInventarioPC());
                if (pc != null) {
                    marca = pc.getMarca();
                }
                sb.append("Codigo: ").append(r.getCodigo())
                  .append(", persona: ").append(r.getCedulaProfesor())
                  .append(" ").append(nombre).append(" ").append(apellido)
                  .append(", equipo: ").append(marca)
                  .append(", recogida: ").append(r.getFechaRecogida())
                  .append(", entrega: ").append(r.getFechaEntrega())
                  .append("\n");
            }
            JOptionPane.showMessageDialog(null, sb.toString());
        }
    }
}
