

# Helper function for coercing JSON output into data.frame for a single pet record. 
# Used by methods pet_get() and pet_getRandom().
pet_record = function(r) {
  records <- names(r)
  
  recordlist <- list()
  
  for (i in 1:length(records)) {
    
    if (records[i] == 'options') {
      ropt <- r$options$option
      
      if (is.data.frame(ropt)) {
        statuses <- data.frame(as.matrix(t(ropt)))
      }
      
      else if (is.list(ropt)) {
        statuses <- data.frame(status.1=ropt[[1]])
      }
      
      else if (is.null(ropt)) {
        statuses <- data.frame(status.1='None')
      }

      colnames(statuses) <- paste('status.', gsub('X', '', colnames(statuses)), sep = '')
      recordlist[[i]] <- statuses
    }
    
    else if (records[i] == 'media') {
        
      if (!is.data.frame(records[i])) {
        photos <- data.frame(photo.1=NA)
      }
      
      else {
        photos <- data.frame(t(r$media$photos$photo$`$t`))
        colnames(photos) <- paste('photo.', colnames(photos), sep = '')
      }
      
      recordlist[[i]] <- photos
    }
    
    else if (records[i] == 'contact') {
      con <- r$contact
    
      contactnames <- names(con)
      contactinfo <- list()
      
      for (i in contactnames) {
        if (!is.na(names(con[i][[1]][1]))) {
          contactinfo[[i]] <- con[i][[1]]$`$t`
        }
      }
      
      recordlist[[i]] <- data.frame(contactinfo)
      
    }
    
    else if (records[i] == 'breeds') {
      breeds <- r$breeds$breed

      breeds.df <- data.frame(t(breeds))
      colnames(breeds.df) <- paste('breed', gsub('X', '', colnames(breeds.df)), sep = '.')
      recordlist[[i]] <- breeds.df
    }
    
    else {
      df <- tryCatch(
        {
          data.frame(r[i][[1]][[1]])
        },
        error = function(cond) {
          data.frame(NA)
        }
      )
      colnames(df) <- names(r[i])
      recordlist[[i]] <- df
    }
  }
  
  pet.df <- data.frame(recordlist)
  colnames(pet.df) <- gsub('X.t', '', colnames(pet.df))
  
  return(pet.df)
}


# Helper function for coercing JSON output from Petfinder database into data.frame.
# Used by pet method pet.find when returning more than one record.
pet_records_df = function(r) {
  records <- names(r)
  
  recordlist <- list()
  
  for (i in 1:length(records)) {
    
    if (records[i] == 'options') {
      ropt <- r$options$option
      status_list <- list()
      
      for (j in 1:length(ropt)) {
        if (!is.null(ropt[[j]])) {
          if (length(ropt[[j]][[1]]) == 1) {
            status_list[[j]] <- data.frame('X1'=ropt[[j]][[1]])
          }
          else {
            status_list[[j]] <- data.frame(t(ropt[[j]][[1]]))  
          }
        }
        else {
          status_list[[j]] <- data.frame('X1'='None')
        }
      }
      
      statuses <- rbind.fill(status_list)
      colnames(statuses) <- paste('status', gsub('X', '', colnames(statuses)), sep='.')
      
      recordlist[[i]] <- statuses
    }
    
    else if (records[i] == 'media') {
      photos <- r$media$photos$photo
      photo_list <- list()
      
      for (j in 1:length(photos)) {
        if (!is.data.frame(photos[[j]])) {
          photo_list[[j]] <- data.frame('X1'=NA)
        }
        else {
          photo_list[[j]] <- data.frame(t(photos[[j]][2]))
        }
      }
      
      photosdf <- rbind.fill(photo_list)
      colnames(photosdf) <- paste('photo.', gsub('X', '', colnames(photosdf)), sep = '')
      
      recordlist[[i]] <- photosdf
    }
    
    else if (records[i] == 'contact') {
      con <- r$contact
      
      contacts <- data.frame(lapply(con, function(x) {
        if (dim(x)[2] == 0) {
          x <- NA
        }
        else {
          x
        }
      }))
      
      contact_df <- rbind.fill(contacts)
      colnames(contact_df) <- names(con)
      
      recordlist[[i]] <- contact_df
    }
    
    else if (records[i] == 'breeds') {
      breed_list <- list()
      breeds <- r$breeds$breed
      
      for (j in 1:length(breeds)) {
        if (is.null(dim(breeds[[j]]))) {
          breed_list[[j]] <- data.frame('X1'=breeds[[j]][[1]])
        }
        else {
          breed_list[[j]] <- data.frame(t(breeds[[j]][[1]]))    
        }
      }
      
      breeddf <- rbind.fill(breed_list)
      colnames(breeddf) <- paste('breed', gsub('X', '', colnames(breeddf)), sep='.')
      
      recordlist[[i]] <- breeddf
    }
    
    else {
      tryCatch(
        df <- r[[i]][1],
        error = function(cond) {
          df <- data.frame(NA)
        }
      )
      
      colnames(df) <- records[i]
      recordlist[[i]] <- df
      
    }
  }
  
  pet.df <- data.frame(recordlist)
  return(pet.df)
}