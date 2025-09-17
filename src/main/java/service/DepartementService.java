package service;

import entity.Departement;
import repository.DepartementRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartementService {

    private final DepartementRepository departementRepository;

    public DepartementService(DepartementRepository departementRepository) {
        this.departementRepository = departementRepository;
    }

    // Retourne tous les départements
    public List<Departement> getAllDepartements() {
        return departementRepository.findAll();
    }

    public String getNomDepartementById(Long idDept) {
        return departementRepository.getNameById(idDept);
    }

}
