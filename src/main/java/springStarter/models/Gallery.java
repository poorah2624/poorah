package springStarter.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="gallery")
@Getter
@Setter
public class Gallery {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long galleryId;
	
	@Column(name="galleryName", nullable=false)
	private String galleryName;
	
	@Column(name="galleryStatus", nullable=false)
	private String galleryStatus;

}
