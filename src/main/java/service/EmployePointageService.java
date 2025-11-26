package service;

import entity.EmployePointage;
import repository.EmployePointageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class EmployePointageService {

    @Autowired
    private EmployePointageRepository employePointageRepository;

    public List<EmployePointage> findAll() {
        return employePointageRepository.findAllByOrderByDepartementAscNomAsc();
    }
    
    public List<EmployePointage> findByDepartement(String departement) {
        return employePointageRepository.findByDepartementOrderByNomAsc(departement);
    }
    
    public List<EmployePointage> findByPoste(String poste) {
        return employePointageRepository.findByPosteOrderByNomAsc(poste);
    }
    
    public List<EmployePointage> searchByNomOrPrenom(String recherche) {
        return employePointageRepository.findByNomOrPrenomContaining(recherche);
    }
    
    public EmployePointage findById(Integer id) {
        return employePointageRepository.findById(id).orElse(null);
    }
    
    // Statistiques par département
    public Map<String, Long> getStatistiquesDepartement() {
        List<Object[]> stats = employePointageRepository.countByDepartement();
        return stats.stream()
            .collect(Collectors.toMap(
                obj -> (String) obj[0],
                obj -> (Long) obj[1]
            ));
    }
    
    // Total employés
    public long getTotalEmployes() {
        return employePointageRepository.count();
    }
}