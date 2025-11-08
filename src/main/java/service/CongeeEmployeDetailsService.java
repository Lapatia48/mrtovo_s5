package service;

import entity.CongeeEmployeDetails;
import repository.CongeeEmployeDetailsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CongeeEmployeDetailsService {

    @Autowired
    private CongeeEmployeDetailsRepository congeeEmployeDetailsRepository;

}