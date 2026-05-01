package springStarter.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="gallery")
public class Gallery {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long galleryId;
	
	@Column(name="galleryName", nullable=false)
	private String galleryName;
	
	@Column(name="galleryStatus", nullable=false)
	private String galleryStatus;

	public Long getGalleryId() {
		return galleryId;
	}

	public void setGalleryId(Long galleryId) {
		this.galleryId = galleryId;
	}

	public String getGalleryName() {
		return galleryName;
	}

	public void setGalleryName(String galleryName) {
		this.galleryName = galleryName;
	}

	public String getGalleryStatus() {
		return galleryStatus;
	}

	public void setGalleryStatus(String galleryStatus) {
		this.galleryStatus = galleryStatus;
	}

	
	
}
