package com.web.airplane.demo.models;


import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;

@Getter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "images")
@Setter
public class Image {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String type;
    private LocalDate uploadDate;
    @Lob
    private byte[] imageData;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @OneToOne(mappedBy = "image", cascade = CascadeType.ALL, orphanRemoval = true)
    private News news;

    public void setId(Long id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setUploadDate(LocalDate uploadDate) {
        this.uploadDate = uploadDate;
    }

    public void setImageData(byte[] imageData) {
        this.imageData = imageData;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setNews(News news) {
        this.news = news;
    }

    public boolean equals(final Object o) {
        if (o == this) return true;
        if (!(o instanceof Image)) return false;
        final Image other = (Image) o;
        if (!other.canEqual((Object) this)) return false;
        final Object this$id = this.getId();
        final Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final Object this$name = this.getName();
        final Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final Object this$type = this.getType();
        final Object other$type = other.getType();
        if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
        final Object this$uploadDate = this.getUploadDate();
        final Object other$uploadDate = other.getUploadDate();
        if (this$uploadDate == null ? other$uploadDate != null : !this$uploadDate.equals(other$uploadDate))
            return false;
        if (!java.util.Arrays.equals(this.getImageData(), other.getImageData())) return false;
        final Object this$user = this.getUser();
        final Object other$user = other.getUser();
        if (this$user == null ? other$user != null : !this$user.equals(other$user)) return false;
        final Object this$news = this.getNews();
        final Object other$news = other.getNews();
        if (this$news == null ? other$news != null : !this$news.equals(other$news)) return false;
        return true;
    }

    protected boolean canEqual(final Object other) {
        return other instanceof Image;
    }

    public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final Object $type = this.getType();
        result = result * PRIME + ($type == null ? 43 : $type.hashCode());
        final Object $uploadDate = this.getUploadDate();
        result = result * PRIME + ($uploadDate == null ? 43 : $uploadDate.hashCode());
        result = result * PRIME + java.util.Arrays.hashCode(this.getImageData());
        final Object $user = this.getUser();
        result = result * PRIME + ($user == null ? 43 : $user.hashCode());
        final Object $news = this.getNews();
        result = result * PRIME + ($news == null ? 43 : $news.hashCode());
        return result;
    }

    public String toString() {
        return "Image(id=" + this.getId() + ", name=" + this.getName() + ", type=" + this.getType() + ", uploadDate=" + this.getUploadDate() + ", imageData=" + java.util.Arrays.toString(this.getImageData()) + ", user=" + this.getUser() + ", news=" + this.getNews() + ")";
    }

}
